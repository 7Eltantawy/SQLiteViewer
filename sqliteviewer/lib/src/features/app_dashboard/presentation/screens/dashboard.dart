import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/core/values/constants.dart';
import 'package:sqliteviewer/src/features/app_dashboard/presentation/components/db_file_card.dart';
import 'package:sqliteviewer/src/features/app_dashboard/presentation/controller/cubit/app_dashboard_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDashboardCubit, AppDashboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset("assets/icons/app_icon.png"),
            ),
            title: const Text("SQLite Viewer"),
            centerTitle: true,
            actions: [Text(appVersion)],
          ),
          body: ListView.builder(
            itemCount: state.openedPaths.length,
            itemBuilder: (context, index) {
              return DBFileCard(dbPath: state.openedPathsReversed[index]);
            },
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: "Open Database",
            child: const Icon(Icons.file_open_outlined),
            onPressed: () {
              context.read<AppDashboardCubit>().pickDatabaseFromFiles();
            },
          ),
        );
      },
    );
  }
}
