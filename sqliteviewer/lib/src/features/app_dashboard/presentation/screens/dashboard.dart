import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/core/values/constants.dart';
import 'package:sqliteviewer/src/features/app_dashboard/presentation/components/db_file_card.dart';
import 'package:sqliteviewer/src/features/app_dashboard/presentation/controller/cubit/app_dashboard_cubit.dart';

import '../components/drag_file_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<AppDashboardCubit, AppDashboardState>(
      builder: (context, state) {
        return DropTarget(
          onDragDone: (details) {
            context.read<AppDashboardCubit>().toggleDraggingState(false);
            context
                .read<AppDashboardCubit>()
                .handleOpenedFile(details.files.first.path);
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
