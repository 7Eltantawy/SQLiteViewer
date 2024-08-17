import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/controller/cubit/db_dashboard_cubit.dart';

class QueryToolBar extends StatelessWidget {
  const QueryToolBar({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Tooltip(
            message: "Execute SQL",
            child: IconButton(
              icon: const Icon(
                Icons.play_circle_outline,
              ),
              onPressed: () async {
                context.read<DbDashboardCubit>().query();
              },
            ),
          ),
          Tooltip(
            message: "Clear SQL Text",
            child: IconButton(
              icon: const Icon(
                Icons.close,
              ),
              onPressed: () async {
                context.read<DbDashboardCubit>().clearQuery();
              },
            ),
          ),
        ],
      ),
    );
  }
}
