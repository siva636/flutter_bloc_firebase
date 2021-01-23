import 'package:flutter/material.dart';

AppBar header() {
  return AppBar(
    title: Text('flutter_bloc_firebase'),
    actions: [
      ElevatedButton(onPressed: () => null, child: Text('Dashboard')),
      ElevatedButton(onPressed: () => null, child: Text('Logout')),
    ],
  );
}
