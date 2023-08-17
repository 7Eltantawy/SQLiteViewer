import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sqliteviewer/src/core/helpers/db_helper.dart';
import 'package:sqliteviewer/src/core/utils/print.dart';

part 'db_dashboard_state.dart';

class DbDashboardCubit extends Cubit<DbDashboardState> {
  final String dbPath;
  DbDashboardCubit(this.dbPath)
      : super(const DbDashboardState(isLoading: true, tables: [])) {
    DatabaseHelper.path = dbPath;
    loadTables();
  }

  Future<void> loadTables() async {
    final tables = await DatabaseHelper.instance.getAllTables();

    emit(state.copyWith(tables: tables, isLoading: false));
  }

  @override
  Future<void> close() {
    try {
      DatabaseHelper.instance.close();
    } catch (e) {
      appPrint(e);
    }
    return super.close();
  }
}
