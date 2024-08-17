import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/core/sql/keywords.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/components/formatter/sql_code_preview.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/controller/cubit/db_dashboard_cubit.dart';

class QueryCodePreview extends StatelessWidget {
  const QueryCodePreview({
    super.key,
    required this.context,
    required this.state,
  });

  final BuildContext context;
  final DbDashboardState state;

  @override
  Widget build(BuildContext context) {
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
}
