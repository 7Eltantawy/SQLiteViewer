part of 'db_dashboard_cubit.dart';

class DbDashboardState extends Equatable {
  final bool isLoading;
  final bool isQuerying;
  final List<String> tables;
  final List<Map<String, dynamic>> result;
  final Map<String, List<String>> tablesColumns;

  const DbDashboardState({
    required this.isLoading,
    required this.isQuerying,
    required this.tables,
    required this.tablesColumns,
    required this.result,
  });

  @override
  List<Object> get props {
    return [
      isLoading,
      isQuerying,
      tables,
      result,
      tablesColumns,
    ];
  }

  DbDashboardState copyWith({
    bool? isLoading,
    bool? isQuerying,
    List<String>? tables,
    List<Map<String, dynamic>>? result,
    Map<String, List<String>>? tablesColumns,
  }) {
    return DbDashboardState(
      isLoading: isLoading ?? this.isLoading,
      isQuerying: isQuerying ?? this.isQuerying,
      tables: tables ?? this.tables,
      result: result ?? this.result,
      tablesColumns: tablesColumns ?? this.tablesColumns,
    );
  }
}
