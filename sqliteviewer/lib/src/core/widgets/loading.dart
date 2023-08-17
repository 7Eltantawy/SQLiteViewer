import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool withScaffold;
  const Loading({super.key, this.withScaffold = false});

  Widget _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: _loadingWidget(),
          )
        : _loadingWidget();
  }
}
