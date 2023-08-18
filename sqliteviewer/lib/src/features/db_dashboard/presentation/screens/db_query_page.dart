import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/core/widgets/loading.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/components/formatter/sql_code_preview.dart';
import 'package:sqliteviewer/src/core/sql/keywords.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/controller/cubit/db_dashboard_cubit.dart';
import 'package:sqliteviewer/src/features/db_table_viewer/presentation/components/table_content_data_grid.dart';

class DBQueryPage extends StatelessWidget {
  const DBQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbDashboardCubit, DbDashboardState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Row(
                  children: [
                    IconButton(
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
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                padding: const EdgeInsets.all(10),
                child: Scrollbar(
                  child: TextField(
                    scrollController:
                        context.read<DbDashboardCubit>().scrollController1,
                    controller:
                        context.read<DbDashboardCubit>().sqlCodeController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    // inputFormatters: [
                    //   ColoredTextFormatter(sqliteReservedKeywords),
                    // ],
                  ),
                ),
              ),
              ListenableBuilder(
                  listenable:
                      context.read<DbDashboardCubit>().sqlCodeController,
                  builder: (_, __) {
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        controller:
                            context.read<DbDashboardCubit>().scrollController2,
                        children: [
                          SQLCodePreview(
                            text: context
                                .read<DbDashboardCubit>()
                                .sqlCodeController
                                .text,
                            tables: state.tables,
                            keywords: sqliteReservedKeywords,
                          ),
                        ],
                      ),
                    );
                  }),
              const Divider(),
              Expanded(
                  flex: 2,
                  child: Card(
                    child: state.isQuerying
                        ? const Loading()
                        : TableContentDataGrid(data: state.result),
                  )),
            ],
          ),
        );
      },
    );
  }
}
