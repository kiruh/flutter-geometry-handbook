import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:geometry/geometry_app.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geometry Handbook',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: Splasher(),
    );
  }
}

class Splasher extends StatefulWidget {
  @override
  SplasherState createState() => new SplasherState();
}

class SplasherState extends State<Splasher> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new GeometryApp(),
      title: new Text(
        'Geometry Handbook',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.asset('images/logo.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(color: Colors.transparent),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}
