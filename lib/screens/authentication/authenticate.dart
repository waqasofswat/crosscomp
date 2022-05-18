import 'package:cross_comp/screens/authentication/signin/signinscreen.dart';
import 'package:cross_comp/screens/authentication/signup/signupscreen.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignInScreen(toggleView) : SignUpScreen(toggleView);
  }
}
