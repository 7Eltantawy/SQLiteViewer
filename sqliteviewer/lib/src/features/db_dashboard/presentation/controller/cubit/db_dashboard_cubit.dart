import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/core/utils/print.dart';

part 'db_dashboard_state.dart';

class DbDashboardCubit extends Cubit<DbDashboardState> {
  final String dbPath;
  final TextEditingController sqlCodeController = TextEditingController();
  DbDashboardCubit(this.dbPath)
      : super(const DbDashboardState(
          isLoading: true,
          tables: [],
          result: [],
          isQuerying: false,
        )) {
    DatabaseHelper.path = dbPath;
    loadTables();
  }

  Future<void> loadTables() async {
    final tables = await DatabaseHelper.instance.getAllTables();

    emit(state.copyWith(tables: tables, isLoading: false));
  }

  Future query() async {
    emit(state.copyWith(isQuerying: true));

    late final List<Map<String, dynamic>> result;
    try {
      result =
          await DatabaseHelper.instance.query(sqlCodeController.text.trim());
    } catch (e) {
      result = [
        {"SQLite Viewer Error": e.toString()}
      ];
    }

    emit(state.copyWith(
      isQuerying: false,
      result: result,
    ));

    loadTables();
  }

  @override
  Future<void> close() {
    sqlCodeController.dispose();
    try {
      DatabaseHelper.instance.close();
    } catch (e) {
      appPrint(e);
    }
    return super.close();
  }
}
