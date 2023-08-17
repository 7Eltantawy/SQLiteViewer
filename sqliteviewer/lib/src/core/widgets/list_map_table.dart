// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ListMapTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const ListMapTable({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          for (int i = 0; i < data.first.keys.length; i++)
            DataColumn(label: Text(data.first.keys.elementAt(i))),
        ],
        rows: data.map((map) {
          return DataRow(cells: [
            for (final entry in map.entries)
              DataCell(Text(entry.value.toString())),
          ]);
        }).toList(),
      ),
    );
  }
}
