import 'package:fastshop/src/controllers/category_controller.dart';
import 'package:fastshop/src/ui/widgets/progress_indicators/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class CategoryEditPage extends StatefulWidget {
  const CategoryEditPage({Key? key}) : super(key: key);

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: categoryController.formCategoryKey,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Obx(
                  () => (categoryController.category.value?.image != null)
                      ? Image.memory(categoryController.category.value!.image!)
                      : Image.network(
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                          categoryController.category.value?.imageDisplay ?? "",
                          loadingBuilder: (context, child, loadingProgress) =>
                              Image.asset('images/loading.gif'),
                          errorBuilder: (context, obj, stackTrace) =>
                              Image.asset('images/base_image.png'),
                        ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        categoryController.category.value?.image =
                            result.files.first.bytes;
                      } else {
                        // Adviser canceled the picker
                      }
                    },
                    child: const Icon(Icons.upload),
                  ),
                ),
              ],
            ),
            TextFormField(
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
          ],
        ),
      ),
    );
  }
}
