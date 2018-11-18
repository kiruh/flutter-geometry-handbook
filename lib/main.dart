import 'package:flutter/material.dart';

import 'package:geometry/geometry_app.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geometry App',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: GeometryApp(),
    );
  }
}
