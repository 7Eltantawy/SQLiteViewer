// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/core/widgets/loading.dart';

import '../components/table_content_data_grid.dart';

class DBTableContentViewer extends StatefulWidget {
  final String tableName;
  final List<String> columns;
  const DBTableContentViewer({
    Key? key,
    required this.tableName,
    required this.columns,
  }) : super(key: key);

  static const String routeName = "/db_table_content";

  static Route route(
      {required String tableName, required List<String> columns}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => DBTableContentViewer(
        tableName: tableName,
        columns: columns,
      ),
    );
  }

  @override
  State<DBTableContentViewer> createState() => _DBTableContentViewerState();
}

class _DBTableContentViewerState extends State<DBTableContentViewer> {
  late final List<Map<String, dynamic>> result;

  bool isLoading = true;
  @override
  void initState() {
    initData();
    super.initState();
  }

  Future initData() async {
    result = await DatabaseHelper.instance
        .getTableContentForSelectedColumns(widget.tableName, widget.columns);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tableName),
        centerTitle: true,
      ),
      body: isLoading ? const Loading() : TableContentDataGrid(data: result),
    );
  }
}
