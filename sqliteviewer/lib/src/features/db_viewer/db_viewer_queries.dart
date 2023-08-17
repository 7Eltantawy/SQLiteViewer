import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/formatter/sql_keywords_formatter.dart';
import 'package:sqliteviewer/src/core/formatter/test.dart';
import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/core/sql/keywords.dart';
import 'package:sqliteviewer/src/core/widgets/list_map_table.dart';
import 'package:sqliteviewer/src/core/widgets/loading.dart';

class DBViewerQueries extends StatefulWidget {
  const DBViewerQueries({super.key});

  @override
  State<DBViewerQueries> createState() => _DBViewerQueriesState();
}

class _DBViewerQueriesState extends State<DBViewerQueries> {
  final TextEditingController sqlCodeController = TextEditingController();
  List<Map<String, dynamic>> result = [];
  bool isQuerying = false;

  Future query() async {
    setState(() {
      isQuerying = true;
    });

    try {
      result =
          await DatabaseHelper.instance.query(sqlCodeController.text.trim());
    } catch (e) {
      result = [
        {"SQLite Viewer Error": e.toString()}
      ];
    }

    setState(() {
      isQuerying = false;
    });
  }

  @override
  void dispose() {
    sqlCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Row(
              children: [
                isQuerying
                    ? const Loading()
                    : IconButton(
                        icon: const Icon(
                          Icons.play_circle_outline,
                        ),
                        onPressed: () async {
                          await query();
                        },
                      )
              ],
            ),
          ),
          Expanded(
              child: Scrollbar(
            thumbVisibility: true,
            child: TextField(
              controller: sqlCodeController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              expands: true,
              decoration: const InputDecoration(),
              inputFormatters: [
                ColoredTextFormatter(sqlLangKeyWordMap),
              ],
              onChanged: (value) {
                setState(() {});
              },
            ),
          )),
          SQLCodePreview(
            text: sqlCodeController.text,
            keywords: sqlLangKeyWordMap,
          ),
          Expanded(
              child: Card(
            child: ListMapTable(data: result),
          )),
        ],
      ),
    );
  }
}
