part of 'db_dashboard_cubit.dart';

class DbDashboardState extends Equatable {
  final bool isLoading;
  final bool isQuerying;
  final List<String> tables;
  final List<Map<String, dynamic>> result;

  const DbDashboardState({
    required this.isLoading,
    required this.isQuerying,
    required this.tables,
    required this.result,
  });

  @override
  List<Object> get props => [isLoading, isQuerying, tables, result];

  DbDashboardState copyWith({
    bool? isLoading,
    bool? isQuerying,
    List<String>? tables,
    List<Map<String, dynamic>>? result,
  }) {
    return DbDashboardState(
      isLoading: isLoading ?? this.isLoading,
      isQuerying: isQuerying ?? this.isQuerying,
      tables: tables ?? this.tables,
      result: result ?? this.result,
    );
  }
}
