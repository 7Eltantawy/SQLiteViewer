// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/extension/string.dart';
import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/core/utils/print.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/screens/db_query_page.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/screens/db_tables_page.dart';

class DBDashboard extends StatefulWidget {
  final String dbPath;
  const DBDashboard({
    Key? key,
    required this.dbPath,
  }) : super(key: key);

  @override
  State<DBDashboard> createState() => _DBDashboardState();
}

class _DBDashboardState extends State<DBDashboard> {
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
            DBTablesPage(),
            DBQueryPage(),
          ],
        ),
      ),
    );
  }
}
