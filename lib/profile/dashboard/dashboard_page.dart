import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Thank You!', style: Theme.of(context).textTheme.headline3),
        // child: Text('Dashboard', style: Theme.of(context).textTheme.headline3),
      ),
    );
  }
}
