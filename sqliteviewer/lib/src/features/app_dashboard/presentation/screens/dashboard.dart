import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/features/app_dashboard/data/data_source/local_storage.dart';
import 'package:sqliteviewer/src/core/utils/print.dart';
import 'package:sqliteviewer/src/core/utils/show_toast.dart';
import 'package:sqliteviewer/src/features/app_dashboard/presentation/components/db_file_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final List<String> openedPaths;
  List<String> get openedPathsReversed => openedPaths.reversed.toList();

  Future<void> pickDatabaseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result == null) return;
    String filePath = result.files.single.path!;

    if (!filePath.endsWith('.db')) {
      showToast("Please select .db file");

      return;
    }

    setState(() {
      final String selectedFilePath = filePath;
      if (openedPaths.contains(selectedFilePath)) {
        openedPaths.removeWhere((e) => e == selectedFilePath);
      }
      openedPaths.add(selectedFilePath);
    });

    await LocalStorageRepo.setLastOpenedFiles(openedPaths);
  }

  @override
  void initState() {
    openedPaths = LocalStorageRepo.lastOpenedFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset("assets/icons/app_icon.png"),
        ),
        title: const Text("SQLite Viewer"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: openedPaths.length,
        itemBuilder: (context, index) {
          return DBFileCard(dbPath: openedPathsReversed[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Open Database",
        child: const Icon(Icons.file_open_outlined),
        onPressed: () async {
          try {
            await pickDatabaseFile();
          } catch (e) {
            appPrint(e);
          }
        },
      ),
    );
  }
}
