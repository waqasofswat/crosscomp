import 'package:cross_comp/route.dart';
import 'package:cross_comp/screens/splashscreen/splashscreen.dart';
import 'package:cross_comp/theme.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrossComps',

      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: SplashScreenX.routeName,
      routes: routex,
      // home: ,
    );
  }
}
