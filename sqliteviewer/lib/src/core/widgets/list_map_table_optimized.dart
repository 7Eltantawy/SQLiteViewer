import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ListMapTablePagination extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const ListMapTablePagination({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ListMapTablePagination> createState() => _ListMapTablePaginationState();
}

class _ListMapTablePaginationState extends State<ListMapTablePagination> {
  int _rowsPerPage = 50;

  late _ListMapDataSource dataSource;

  @override
  void initState() {
    dataSource = _ListMapDataSource(
      widget.data,
      _rowsPerPage,
      (value) {},
    );
    super.initState();
  }

  Widget _buildDataGrid() {
    return SfDataGrid(
      source: dataSource,
      rowsPerPage: _rowsPerPage,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      allowColumnsResizing: true,
      allowEditing: true,
      allowSorting: true,
      allowFiltering: true,
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      highlightRowOnHover: true,
      columns: dataSource.header(),
    );
  }

  Widget _bottomBar() {
    return SfDataPager(
      delegate: dataSource,
      availableRowsPerPage: const <int>[15, 25, 50, 100, 250, 500],
      pageCount: (widget.data.length / _rowsPerPage).ceil().toDouble(),
      onRowsPerPageChanged: (int? rowsPerPage) {
        setState(() {
          _rowsPerPage = rowsPerPage!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const SizedBox();
    }

    return Scaffold(
      body: _buildDataGrid(),
      bottomNavigationBar: _bottomBar(),
    );
  }
}

class _ListMapDataSource extends DataGridSource {
  _ListMapDataSource(this._data, this.count, this.onCellPressed);

  final int count;
  final List<Map<String, dynamic>> _data;
  final ValueChanged<String> onCellPressed;

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
    num? numValue = num.tryParse(entry.value.toString());
    if (numValue != null) {
      if (numValue is int) {
        return DataGridCell<int>(
          columnName: entry.key,
          value: entry.value,
        );
      } else {
        return DataGridCell<double>(
          columnName: entry.key,
          value: entry.value,
        );
      }
    } else {
      return DataGridCell<String>(
        columnName: entry.key,
        value: entry.value.toString(),
      );
    }
  }

  /// Table Header
  List<GridColumn> header() => <GridColumn>[
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

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (e) {
          return GestureDetector(
            onTap: () {
              onCellPressed.call(e.value.toString());
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(e.value.toString()),
            ),
          );
        },
      ).toList(),
    );
  }
}
