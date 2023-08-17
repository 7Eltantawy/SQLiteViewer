import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TableContentDataGridDataSource extends DataGridSource {
  TableContentDataGridDataSource(this._data, this.count, this.onCellPressed);

  final int count;
  final List<Map<String, dynamic>> _data;
  final ValueChanged<String> onCellPressed;

  /// Table Header
  List<GridColumn> header() {
    return <GridColumn>[
      for (final key in _data.first.keys)
        GridColumn(
          columnName: key,
          label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Text(
              key,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
    ];
  }

  @override
  List<DataGridRow> get rows {
    final List<DataGridRow> rows = [];

    for (var row in _data) {
      final gridRow = DataGridRow(
        cells: [
          for (final entry in row.entries) buildDataCell(entry),
        ],
      );
      rows.add(gridRow);
    }

    return rows;
  }

  DataGridCell buildDataCell(MapEntry<String, dynamic> entry) {
    switch (entry.value.runtimeType) {
      case int:
        return DataGridCell<int>(
          columnName: entry.key,
          value: entry.value,
        );
      case double:
        return DataGridCell<double>(
          columnName: entry.key,
          value: entry.value,
        );
      default:
        return DataGridCell<String>(
          columnName: entry.key,
          value: entry.value.toString(),
        );
    }
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (e) {
          return GestureDetector(
            onTap: () {
              onCellPressed.call(e.value.toString());
            },
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  e.value.toString(),
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
