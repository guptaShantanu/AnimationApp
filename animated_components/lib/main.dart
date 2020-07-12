import 'package:animatedcomponents/Screens/bottom_swiper.dart';
import 'package:animatedcomponents/Screens/menu_screen.dart';
import 'package:animatedcomponents/Screens/rotating_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
    );
  }
}
