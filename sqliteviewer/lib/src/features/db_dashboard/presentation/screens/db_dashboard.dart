// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/core/extension/string.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/controller/cubit/db_dashboard_cubit.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/screens/db_query_page.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/screens/db_tables_page.dart';

class DBDashboard extends StatelessWidget {
  final String dbPath;
  const DBDashboard({
    Key? key,
    required this.dbPath,
  }) : super(key: key);

  static const String routeName = "/db_dashboard";

  static Route route(String dbPath) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => DbDashboardCubit(dbPath),
        child: DBDashboard(dbPath: dbPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(dbPath.getFileName()),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(child: Text("Tables")),
              Tab(child: Text("Queries")),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            DBTablesPage(),
            DBQueryPage(),
          ],
        ),
      ),
    );
  }
}
