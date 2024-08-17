import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/core/values/constants.dart';
import 'package:sqliteviewer/src/features/app_dashboard/presentation/components/db_file_card.dart';
import 'package:sqliteviewer/src/features/app_dashboard/presentation/controller/cubit/app_dashboard_cubit.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/screens/db_dashboard.dart';

import '../components/drag_file_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<AppDashboardCubit, AppDashboardState>(
      builder: (context, state) {
        return DropTarget(
          onDragDone: (details) async {
            context.read<AppDashboardCubit>().toggleDraggingState(false);
            final result = await context
                .read<AppDashboardCubit>()
                .handleOpenedFile(details.files.first.path);

            if (result) {
              // Safely access the context after checking if mounted
              final scaffoldContext = scaffoldKey.currentState?.context;
              if (scaffoldContext != null && scaffoldContext.mounted) {
                Navigator.push(scaffoldContext,
                    DBDashboard.route(details.files.first.path));
              }
            }
          },
          onDragEntered: (detail) {
            context.read<AppDashboardCubit>().toggleDraggingState(true);
          },
          onDragExited: (detail) {
            context.read<AppDashboardCubit>().toggleDraggingState(false);
          },
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset("assets/icons/app_icon.png"),
              ),
              title: const Text("SQLite Viewer"),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(appVersion),
                )
              ],
            ),
            body: Stack(
              children: [
                if (state.isDragging) const Center(child: DragFileCard()),
                ListView.builder(
                  itemCount: state.openedPaths.length,
                  itemBuilder: (context, index) {
                    return DBFileCard(dbPath: state.openedPathsReversed[index]);
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: "Open Database",
              child: const Icon(Icons.file_open_outlined),
              onPressed: () {
                context
                    .read<AppDashboardCubit>()
                    .pickDatabaseFromFiles(scaffoldKey);
              },
            ),
          ),
        );
      },
    );
  }
}
