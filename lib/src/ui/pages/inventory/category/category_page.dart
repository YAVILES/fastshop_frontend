import 'package:fastshop/src/components/generic_table/generic_table_responsive.dart';
import 'package:fastshop/src/providers/category_provider.dart';
import 'package:fastshop/src/router/pages.dart';
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
          return const Text('Opciones');
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
          GenericTableResponsive(
            headers: _headers,
            onSource: (Map<String, dynamic> params, String? url) {
              return categoryProvider.getCategoriesPaginated(url, params);
            },
            params: const {},
          ),
        ],
      ),
    );
  }
}
