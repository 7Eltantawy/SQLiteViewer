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
    return data.isEmpty
        ? const SizedBox()
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                for (final key in data.first.keys)
                  DataColumn(label: Text(key.toString())),
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
