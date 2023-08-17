// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/extension/string.dart';

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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.dbPath.getFileName()),
          centerTitle: true,
        ),
        body: const Text("data"),
      ),
    );
  }
}
