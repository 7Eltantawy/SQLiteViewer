import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/controller/cubit/db_dashboard_cubit.dart';

class QueryCodeInput extends StatelessWidget {
  const QueryCodeInput({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
}
