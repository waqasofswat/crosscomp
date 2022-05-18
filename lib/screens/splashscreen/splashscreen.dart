import 'dart:async';

import 'package:cross_comp/screens/authentication/authenticate.dart';
import 'package:cross_comp/screens/mainPageAfter/homePage.dart';
import 'package:cross_comp/screens/mainpageBefore/mainPage.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'component/body.dart';

class SplashScreenX extends StatefulWidget {
  const SplashScreenX({Key? key}) : super(key: key);

  static String routeName = "/splash";

  @override
  _SplashScreenXState createState() => _SplashScreenXState();
}

class _SplashScreenXState extends State<SplashScreenX> {
  void initState() {
    // FocusScope.of(context).requestFocus(FocusNode());
    super.initState();
    getLogin();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }

  Future<void> getLogin() async {
    await HelperFunction.getUserLoggedInSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          if (value) {
            HelperFunction.getWhenSharedPreference().then((value) {
              if (value != null) {
                setState(() {
                  if (value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    Timer(
                        Duration(seconds: 3),
                        () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Authenticate())));
                  }
                });
              } else {
                Timer(
                    Duration(seconds: 3),
                    () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authenticate())));
              }
            });
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          } else {
            Timer(
                Duration(seconds: 3),
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate())));
          }
        });
      } else {
        Timer(
            Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Authenticate())));
      }
    });
  }
}
