part of 'app_dashboard_cubit.dart';

@immutable
class AppDashboardState extends Equatable {
  final List<String> openedPaths;
  final bool isDragging;

  const AppDashboardState({
    required this.openedPaths,
    required this.isDragging,
  });

  List<String> get openedPathsReversed => openedPaths.reversed.toList();

  @override
  List<Object> get props => [openedPaths, isDragging];

  AppDashboardState copyWith({
    List<String>? openedPaths,
    bool? isDragging,
  }) {
    return AppDashboardState(
      openedPaths: openedPaths ?? this.openedPaths,
      isDragging: isDragging ?? this.isDragging,
    );
  }
}
