import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ListMapTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const ListMapTable({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox();
    }

    return SfDataGrid(
      rowsPerPage: 10,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      allowColumnsDragging: true,
      allowColumnsResizing: true,
      columnResizeMode: ColumnResizeMode.onResizeEnd,
      allowEditing: true,
      allowSorting: true,
      allowFiltering: true,
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      highlightRowOnHover: true,
      source: _ListMapDataSource(data),
      columns: [
        for (final key in data.first.keys)
          GridColumn(
            columnName: key,
            label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text(key),
            ),
          ),
      ],
    );
  }
}

class _ListMapDataSource extends DataGridSource {
  _ListMapDataSource(this._data);

  final List<Map<String, dynamic>> _data;

  @override
  List<DataGridRow> get rows => _data
      .map<DataGridRow>((data) => DataGridRow(cells: [
            for (final entry in data.entries)
              DataGridCell<String>(
                columnName: entry.key,
                value: entry.value.toString(),
              ),
          ]))
      .toList();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
