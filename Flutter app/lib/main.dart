import 'package:flutter/material.dart';

import 'package:api_moordb/Screens/WelcomeScreen.dart';
import 'package:api_moordb/Screens/LogingScreen.dart';
import 'package:api_moordb/Screens/UploadScreen.dart';
import 'package:api_moordb/Screens/RegisterScreen.dart';
import 'Screens/HomeScreen.dart';


void main() => runApp(MyApp());

/*
* how to fetch json
* https://medium.com/@ekosuprastyo15/flutter-json-array-parse-of-objects-dbf36a7aa08d
* */


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        'RegisterScreen': (context) => RegisterScreen(),
        'LogingScreen': (context) => LogingScreen(),
        'UploadScreen': (context) => UploadScreen(),
        'HomeScreen': (context) => Home(),
      },
    );
  }
}


