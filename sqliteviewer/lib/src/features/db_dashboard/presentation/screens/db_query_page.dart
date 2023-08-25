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
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<DbDashboardCubit, DbDashboardState>(
        builder: (context, state) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            queryToolBar(context),
            if (width < 600) ...[
              queryCodeInput(context),
              queryCodePreview(context, state),
            ] else
              Expanded(
                child: Card(
                  child: Row(
                    children: [
                      Expanded(child: queryCodeInput(context)),
                      const VerticalDivider(),
                      Expanded(child: queryCodePreview(context, state)),
                    ],
                  ),
                ),
              ),
            const Divider(),
            Expanded(
              flex: 2,
              child: Card(
                child: state.isQuerying
                    ? const Loading()
                    : TableContentDataGrid(data: state.result),
              ),
            ),
          ],
        ),
      );
    });
  }

  ListenableBuilder queryCodePreview(
    BuildContext context,
    DbDashboardState state,
  ) {
    return ListenableBuilder(
      listenable: context.read<DbDashboardCubit>().sqlCodeController,
      builder: (_, __) {
        return Container(
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),
          child: ListView(
            controller: context.read<DbDashboardCubit>().scrollController2,
            children: [
              SQLCodePreview(
                text: context.read<DbDashboardCubit>().sqlCodeController.text,
                tablesColumns: state.tablesColumns,
                keywords: sqliteReservedKeywords,
                dataTypeKeywords: sqliteDataTypeKeywords,
              ),
            ],
          ),
        );
      },
    );
  }

  Container queryCodeInput(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      child: Scrollbar(
        controller: context.read<DbDashboardCubit>().scrollController1,
        child: TextField(
          scrollController: context.read<DbDashboardCubit>().scrollController1,
          controller: context.read<DbDashboardCubit>().sqlCodeController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          expands: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: "Write Code Here".toUpperCase(),
          ),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          // inputFormatters: [
          //   ColoredTextFormatter(sqliteReservedKeywords),
          // ],
        ),
      ),
    );
  }

  Card queryToolBar(BuildContext context) {
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
