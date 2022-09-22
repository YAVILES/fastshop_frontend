import 'package:fastshop/src/components/generic_table/generic_table_responsive.dart';
import 'package:fastshop/src/providers/brand_provider.dart';
import 'package:fastshop/src/providers/utils_provider.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:fastshop/src/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_table/responsive_table.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({Key? key}) : super(key: key);

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  late List<DatatableHeader> _headers;
  BrandProvider brandProvider = BrandProvider();
  String baseURL = BrandProvider.baseUrl;
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
                  '${Routes.inventory}${Routes.brandEdit}/${row["id"]}');
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
                    Get.toNamed('${Routes.inventory}${Routes.brandEdit}'),
                child: const Text('Crear Marca'),
              ),
            ),
          ),
          GenericTableResponsive(
            headers: _headers,
            onSource: (Map<String, dynamic> params, String? url) {
              return UtilsProvider.getListPaginated(params, url ?? baseURL);
            },
            filenameExport: 'categorias',
            onExport: (params) {
              return UtilsProvider.export(baseURL);
            },
            onImport: (params) async {
              try {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  // allowedExtensions: ['jpg'],
                  allowMultiple: false,
                );

                if (result != null) {
                  final resp =
                      await UtilsProvider.import(baseURL, result.files.first);
                  if (resp != null) {
                    CustomSnackBar.success(message: 'Carga masiva Exitosa');
                  } else {
                    CustomSnackBar.error(
                        message: 'No fue posible cargar la información');
                  }
                } else {
                  // User canceled the picker
                }
              } on FormatException {
                CustomSnackBar.error(
                    message: 'El archivo no tiene un formato correcto');
              }
            },
          ),
        ],
      ),
    );
  }
}