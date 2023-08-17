// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../db_table_viewer/presentation/screens/db_table_columns_select.dart';

class DBTableCard extends StatelessWidget {
  final String tableName;
  const DBTableCard({
    Key? key,
    required this.tableName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.table_chart_outlined),
      title: Text(tableName),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DBTableColumnsSelectViewer(tableName: tableName);
            },
          ),
        );
      },
    );
  }
}
