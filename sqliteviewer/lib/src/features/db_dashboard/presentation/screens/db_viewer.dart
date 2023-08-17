// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/extension/string.dart';
import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/core/utils/print.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/screens/db_viewer_queries.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/screens/db_viewer_tables.dart';

class DBViewer extends StatefulWidget {
  final String dbPath;
  const DBViewer({
    Key? key,
    required this.dbPath,
  }) : super(key: key);

  @override
  State<DBViewer> createState() => _DBViewerState();
}

class _DBViewerState extends State<DBViewer> {
  @override
  void initState() {
    DatabaseHelper.path = widget.dbPath;
    super.initState();
  }

  @override
  void dispose() {
    try {
      DatabaseHelper.instance.close();
    } catch (e) {
      appPrint(e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.dbPath.getFileName()),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(child: Text("Tables")),
              Tab(child: Text("Queries")),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            DBViewerTables(),
            DBViewerQueries(),
          ],
        ),
      ),
    );
  }
}
