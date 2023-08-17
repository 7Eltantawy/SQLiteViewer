import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/core/widgets/db_table_card.dart';
import 'package:sqliteviewer/src/core/widgets/loading.dart';

class DBViewerTables extends StatefulWidget {
  const DBViewerTables({super.key});

  @override
  State<DBViewerTables> createState() => _DBViewerTablesState();
}

class _DBViewerTablesState extends State<DBViewerTables> {
  late final List<String> tables;
  bool isLoading = true;
  @override
  void initState() {
    initData();
    super.initState();
  }

  Future initData() async {
    tables = await DatabaseHelper.instance.getAllTables();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading(
            withScaffold: true,
          )
        : Scaffold(
            body: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: tables.length,
              itemBuilder: (context, index) {
                return DBTableCard(
                  tableName: tables[index],
                );
              },
            ),
          );
  }
}
