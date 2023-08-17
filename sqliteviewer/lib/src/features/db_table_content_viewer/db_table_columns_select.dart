// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/core/utils/print.dart';
import 'package:sqliteviewer/src/core/widgets/loading.dart';
import 'package:sqliteviewer/src/features/db_table_content_viewer/db_table_content_viewer.dart';

class DBTableColumnsSelectViewer extends StatefulWidget {
  final String tableName;
  const DBTableColumnsSelectViewer({
    Key? key,
    required this.tableName,
  }) : super(key: key);

  @override
  State<DBTableColumnsSelectViewer> createState() =>
      _DBTableColumnsSelectViewerState();
}

class _DBTableColumnsSelectViewerState
    extends State<DBTableColumnsSelectViewer> {
  late final List<Map<String, dynamic>> result;
  late final List<String> allColumns;
  final List<String> selectedColumns = []; // List to store selected columns

  bool isLoading = true;
  @override
  void initState() {
    initData();
    super.initState();
  }

  Future initData() async {
    result = await DatabaseHelper.instance.getColumnNames(widget.tableName);
    allColumns = result.map((column) => column['name'] as String).toList();
    selectedColumns.addAll(allColumns);

    appPrint(result);
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
      body: isLoading
          ? const Loading()
          : ListView.separated(
              itemCount: allColumns.length,
              itemBuilder: (context, index) {
                final column = allColumns[index];
                return CheckboxListTile(
                  title: Text(column),
                  value: selectedColumns.contains(column),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedColumns.add(column);
                      } else {
                        selectedColumns.remove(column);
                      }
                    });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: ListTile(
          title: const Text("Show", textAlign: TextAlign.center),
          onTap: () {
            /// Sort columns as in database table
            selectedColumns.sort(
              (a, b) {
                final aMap =
                    result.firstWhere((element) => element["name"] == a);

                return (aMap["cid"] as int);
              },
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DBTableContentViewer(
                    tableName: widget.tableName,
                    columns: selectedColumns,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
