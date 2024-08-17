import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:sqliteviewer/src/core/widgets/loading.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/components/query_tool_bar.dart';
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
            QueryToolBar(context: context),
            const Expanded(child: SqlCodeEditor()),
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
}

class SqlCodeEditor extends StatelessWidget {
  const SqlCodeEditor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: const CodeThemeData(styles: atomOneDarkTheme),
      child: CodeField(
        background: Colors.transparent,
        controller: context.read<DbDashboardCubit>().codeController,
        textStyle: const TextStyle(fontFamily: 'SourceCode'),
        wrap: true,
      ),
    );
  }
}
