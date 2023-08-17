// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_dashboard_cubit.dart';

@immutable
class AppDashboardState extends Equatable {
  final List<String> openedPaths;

  const AppDashboardState({
    required this.openedPaths,
  });

  List<String> get openedPathsReversed => openedPaths.reversed.toList();

  @override
  List<Object> get props => [openedPaths];

  AppDashboardState copyWith({
    List<String>? openedPaths,
  }) {
    return AppDashboardState(
      openedPaths: openedPaths ?? this.openedPaths,
    );
  }
}
