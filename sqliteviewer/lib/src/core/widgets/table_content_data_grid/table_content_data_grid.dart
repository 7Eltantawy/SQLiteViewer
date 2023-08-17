import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/widgets/table_content_data_grid/data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TableContentDataGrid extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const TableContentDataGrid({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<TableContentDataGrid> createState() => _TableContentDataGridState();
}

class _TableContentDataGridState extends State<TableContentDataGrid> {
  int _rowsPerPage = 50;

  late TableContentDataGridDataSource dataSource;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    dataSource = TableContentDataGridDataSource(
      widget.data,
      _rowsPerPage,
      (value) => showCellContent(value),
    );
  }

  @override
  void didUpdateWidget(covariant TableContentDataGrid oldWidget) {
    if (oldWidget.data != widget.data) {
      getData();
    }
    super.didUpdateWidget(oldWidget);
  }

  void showCellContent(String value) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            // constraints: const BoxConstraints(minHeight: 100, maxHeight: 350),
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Scrollbar(
                child: ListView(
                  padding: const EdgeInsets.all(10.0),
                  shrinkWrap: true,
                  children: [
                    SelectableText(
                      value.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDataGrid() {
    return widget.data.isEmpty
        ? const SizedBox()
        : SfDataGrid(
            source: dataSource,
            rowsPerPage: _rowsPerPage,
            columns: dataSource.header(),
            allowEditing: true,
            allowSorting: true,
            allowFiltering: true,
            highlightRowOnHover: true,
            allowColumnsResizing: true,
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            columnWidthMode: ColumnWidthMode.fitByColumnName,
          );
  }

  Widget _bottomBar() {
    return SfDataPager(
      delegate: dataSource,
      availableRowsPerPage: const <int>[15, 25, 50, 100, 250, 500],
      pageCount: widget.data.isEmpty
          ? 1
          : (widget.data.length / _rowsPerPage).ceil().toDouble(),
      navigationItemWidth: 30,
      onRowsPerPageChanged: (int? rowsPerPage) {
        setState(() {
          _rowsPerPage = rowsPerPage!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildDataGrid(),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        child: _bottomBar(),
      ),
    );
  }
}
