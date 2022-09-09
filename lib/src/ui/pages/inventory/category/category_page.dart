import 'package:fastshop/src/components/generic_table/generic_table_responsive.dart';
import 'package:fastshop/src/controllers/category_controller.dart';
import 'package:fastshop/src/providers/category_provider.dart';
import 'package:fastshop/src/providers/utils_provider.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:fastshop/src/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_table/responsive_table.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<DatatableHeader> _headers;
  CategoryProvider categoryProvider = CategoryProvider();
  String baseURL = CategoryProvider.baseUrl;
  @override
  void initState() {
    _headers = [
      DatatableHeader(text: "Código", value: "internal_code"),
      DatatableHeader(text: "descripción", value: "description"),
      DatatableHeader(
        text: "Estatus",
        value: "status",
        sourceBuilder: (value, row) => Center(
          child: Text(value == 1 ? 'Activo' : 'Inactivo'),
        ),
      ),
      DatatableHeader(
        text: "Acciones",
        value: "id",
        sourceBuilder: (value, row) {
          return IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Get.toNamed(
                  '${Routes.inventory}${Routes.categoryEdit}/${row["id"]}');
            },
            icon: const Icon(Icons.edit_outlined),
          );
        },
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () =>
                    Get.toNamed('${Routes.inventory}${Routes.categoryEdit}'),
                child: const Text('Crear Categoría'),
              ),
            ),
          ),
          GetBuilder<CategoryController>(
            initState: (_) {},
            builder: (controller) {
              return GenericTableResponsive(
                headers: _headers,
                onSource: (Map<String, dynamic> params, String? url) {
                  return UtilsProvider.getListPaginated(params, url ?? baseURL);
                },
                filenameExport: 'categorias',
                onExport: (params) {
                  return UtilsProvider.export(baseURL);
                },
                onImport: (params) async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    // allowedExtensions: ['jpg'],
                    allowMultiple: false,
                  );

                  if (result != null) {
                    final resp =
                        await UtilsProvider.import(baseURL, result.files.first);
                    if (resp != null) {
                      CustomSnackBar.success(message: 'Carga masiva Exitosa');
                      controller.update();
                    } else {
                      CustomSnackBar.error(
                          message: 'No fue posible cargar la información');
                    }
                  } else {
                    // User canceled the picker
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
