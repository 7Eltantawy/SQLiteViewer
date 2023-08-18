import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/core/utils/print.dart';

part 'db_dashboard_state.dart';

class DbDashboardCubit extends Cubit<DbDashboardState> {
  final String dbPath;
  final TextEditingController sqlCodeController = TextEditingController();
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();

  DbDashboardCubit(this.dbPath)
      : super(const DbDashboardState(
          isLoading: true,
          tables: [],
          result: [],
          isQuerying: false,
          tablesColumns: {},
        )) {
    DatabaseHelper.path = dbPath;
    loadTables();
    scrollController1.addListener(_scrollListener);
    scrollController2.addListener(_scrollListener);
  }
  void _scrollListener() {
    if (scrollController1.position.userScrollDirection ==
        ScrollDirection.forward) {
      scrollController2.jumpTo(scrollController1.offset);
    } else if (scrollController1.position.userScrollDirection ==
        ScrollDirection.reverse) {
      scrollController2.jumpTo(scrollController1.offset);
    }
  }

  Future<void> loadTables() async {
    final tables = await DatabaseHelper.instance.getAllTables();
    final Map<String, List<String>> tablesColumns = {};

    for (var table in tables) {
      final List<String> columns =
          (await DatabaseHelper.instance.getColumnNames(table))
              .map((column) => column['name'] as String)
              .toList();

      tablesColumns[table] = columns;
    }

    emit(state.copyWith(
      tables: tables,
      isLoading: false,
      tablesColumns: tablesColumns,
    ));
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

  void clearQuery() {
    sqlCodeController.clear();
  }

  @override
  Future<void> close() {
    sqlCodeController.dispose();
    scrollController1.dispose();
    scrollController2.dispose();
    try {
      DatabaseHelper.instance.close();
    } catch (e) {
      appPrint(e);
    }
    return super.close();
  }
}
