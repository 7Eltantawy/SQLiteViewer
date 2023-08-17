import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/components/db_table_card.dart';
import 'package:sqliteviewer/src/core/widgets/loading.dart';

class DBTablesPage extends StatefulWidget {
  const DBTablesPage({super.key});

  @override
  State<DBTablesPage> createState() => _DBTablesPageState();
}

class _DBTablesPageState extends State<DBTablesPage> {
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
