import 'package:fastshop/src/controllers/category_controller.dart';
import 'package:fastshop/src/ui/widgets/progress_indicators/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoryEditPage extends StatefulWidget {
  CategoryEditPage({Key? key, this.id}) : super(key: key);
  String? id;
  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? CategoryFormPage(categoryController: categoryController)
        : FutureBuilder(
            future: categoryController.getCategory(widget.id!),
            builder: (_, AsyncSnapshot<Object?> snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? CategoryFormPage(categoryController: categoryController)
                    : const CustomProgressIndicator(),
          );
  }
}

class CategoryFormPage extends StatelessWidget {
  const CategoryFormPage({
    Key? key,
    required this.categoryController,
  }) : super(key: key);

  final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    printInfo(
        info:
            'info int. code: ${categoryController.category.value?.internalCode}');
    return SingleChildScrollView(
      child: Form(
        key: categoryController.formCategoryKey,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GetBuilder<CategoryController>(
                  builder: (controller) {
                    return (controller.category.value?.image?.bytes != null)
                        ? Image.memory(controller.category.value!.image!.bytes!)
                        : Image.network(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            controller.category.value?.imageDisplay ?? "",
                            loadingBuilder: (context, child, loadingProgress) =>
                                Image.asset('images/loading.gif'),
                            errorBuilder: (context, obj, stackTrace) =>
                                Image.asset('images/base_image.png'),
                          );
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () async {
                      categoryController.uploadImage();
                    },
                    child: const Icon(Icons.upload),
                  ),
                ),
              ],
            ),
            TextFormField(
              initialValue: categoryController.category.value?.internalCode,
              decoration: const InputDecoration(
                hintText: 'Código',
                labelText: 'Código',
              ),
              onChanged: (value) {
                categoryController.category.value?.internalCode = value;
              },
              onSaved: (value) {
                categoryController.category.value?.internalCode = value ?? "";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "La código es requerido";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: categoryController.category.value?.description,
              decoration: const InputDecoration(
                hintText: 'Descripción',
                labelText: 'Descripción',
              ),
              onChanged: (value) {
                categoryController.category.value?.description = value;
              },
              onSaved: (value) {
                categoryController.category.value?.description = value ?? "";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "La descripción es requerida";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Obx(() {
              return categoryController.saving.isFalse
                  ? ElevatedButton(
                      child: const Text("Guardar"),
                      onPressed: () => categoryController.saveCategory(),
                    )
                  : const CustomProgressIndicator();
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
