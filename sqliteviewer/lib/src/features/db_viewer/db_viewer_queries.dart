import 'package:flutter/material.dart';

class DBViewerQueries extends StatefulWidget {
  const DBViewerQueries({super.key});

  @override
  State<DBViewerQueries> createState() => _DBViewerQueriesState();
}

class _DBViewerQueriesState extends State<DBViewerQueries> {
  final TextEditingController sqlCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.play_circle_outline,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          const Flexible(
              child: Scrollbar(
            thumbVisibility: true,
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              expands: true,
              decoration: InputDecoration(),
            ),
          )),
          Flexible(
              child: Card(
            child: ListView(
              children: const [
                Text(
                  "data",
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
