import 'package:flutter/material.dart';

class OldListMapTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const OldListMapTable({
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
