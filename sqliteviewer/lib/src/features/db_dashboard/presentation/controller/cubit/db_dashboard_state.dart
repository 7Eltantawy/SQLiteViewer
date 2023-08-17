// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'db_dashboard_cubit.dart';

class DbDashboardState extends Equatable {
  final bool isLoading;
  final List<String> tables;
  const DbDashboardState({
    required this.isLoading,
    required this.tables,
  });

  @override
  List<Object> get props => [];

  DbDashboardState copyWith({
    bool? isLoading,
    List<String>? tables,
  }) {
    return DbDashboardState(
      isLoading: isLoading ?? this.isLoading,
      tables: tables ?? this.tables,
    );
  }
}
