import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/components/db_table_card.dart';
import 'package:sqliteviewer/src/core/widgets/loading.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/controller/cubit/db_dashboard_cubit.dart';

class DBTablesPage extends StatelessWidget {
  const DBTablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbDashboardCubit, DbDashboardState>(
      builder: (context, state) {
        return state.isLoading
            ? const Loading(
                withScaffold: true,
              )
            : Scaffold(
                body: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: state.tables.length,
                  itemBuilder: (context, index) {
                    return DBTableCard(
                      tableName: state.tables[index],
                    );
                  },
                ),
              );
      },
    );
  }
}
