import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/components/formatter/sql_keywords_formatter.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/components/formatter/test.dart';
import 'package:sqliteviewer/src/core/sql/keywords.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/controller/cubit/db_dashboard_cubit.dart';
import 'package:sqliteviewer/src/features/db_table_viewer/presentation/components/table_content_data_grid.dart';
import 'package:sqliteviewer/src/core/widgets/loading.dart';

class DBQueryPage extends StatelessWidget {
  const DBQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbDashboardCubit, DbDashboardState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    state.isQuerying
                        ? const Loading()
                        : IconButton(
                            icon: const Icon(
                              Icons.play_circle_outline,
                            ),
                            onPressed: () async {
                              context.read<DbDashboardCubit>().query();
                            },
                          )
                  ],
                ),
              ),
              Expanded(
                  child: Scrollbar(
                thumbVisibility: true,
                child: TextField(
                  controller:
                      context.read<DbDashboardCubit>().sqlCodeController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  decoration: const InputDecoration(),
                  inputFormatters: [
                    ColoredTextFormatter(sqliteReservedKeywords),
                  ],
                ),
              )),
              SQLCodePreview(
                text: context.read<DbDashboardCubit>().sqlCodeController.text,
                keywords: sqliteReservedKeywords,
              ),
              Expanded(
                  child: Card(
                child: TableContentDataGrid(data: state.result),
              )),
            ],
          ),
        );
      },
    );
  }
}
