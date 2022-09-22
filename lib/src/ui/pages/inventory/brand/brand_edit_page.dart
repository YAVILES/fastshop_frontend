import 'package:fastshop/src/controllers/brand_controller.dart';
import 'package:fastshop/src/ui/widgets/progress_indicators/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BrandEditPage extends StatefulWidget {
  BrandEditPage({Key? key, this.id}) : super(key: key);
  String? id;
  @override
  State<BrandEditPage> createState() => _BrandEditPageState();
}

class _BrandEditPageState extends State<BrandEditPage> {
  BrandController categoryController = Get.find<BrandController>();

  @override
  Widget build(BuildContext context) {
    return widget.id == null
        ? BrandFormPage(categoryController: categoryController)
        : FutureBuilder(
            future: categoryController.getBrand(widget.id!),
            builder: (_, AsyncSnapshot<Object?> snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? BrandFormPage(categoryController: categoryController)
                    : const CustomProgressIndicator(),
          );
  }
}

class BrandFormPage extends StatelessWidget {
  const BrandFormPage({
    Key? key,
    required this.categoryController,
  }) : super(key: key);

  final BrandController categoryController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: categoryController.formBrandKey,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GetBuilder<BrandController>(
                  builder: (controller) {
                    return (controller.brand.value?.image?.bytes != null)
                        ? Image.memory(
                            height: 300,
                            controller.brand.value!.image!.bytes!,
                          )
                        : Image.network(
                            height: 300,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            controller.brand.value?.imageDisplay ?? "",
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
            const SizedBox(height: 10),
            TextFormField(
              initialValue: categoryController.brand.value?.internalCode,
              decoration: const InputDecoration(
                hintText: 'Código',
                labelText: 'Código',
              ),
              onChanged: (value) {
                categoryController.brand.value?.internalCode = value;
              },
              onSaved: (value) {
                categoryController.brand.value?.internalCode = value ?? "";
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
              initialValue: categoryController.brand.value?.description,
              decoration: const InputDecoration(
                hintText: 'Descripción',
                labelText: 'Descripción',
              ),
              onChanged: (value) {
                categoryController.brand.value?.description = value;
              },
              onSaved: (value) {
                categoryController.brand.value?.description = value ?? "";
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "La descripción es requerida";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Obx(() {
              return categoryController.saving.isFalse
                  ? ElevatedButton(
                      child: const Text("Guardar"),
                      onPressed: () => categoryController.saveBrand(),
                    )
                  : const CustomProgressIndicator();
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
