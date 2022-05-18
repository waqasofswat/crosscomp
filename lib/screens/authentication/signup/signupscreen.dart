import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  // const SignUpScreen({Key? key}) : super(key: key);
  final Function toggle;

  SignUpScreen(this.toggle);

  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Sign Up"),
      ),
      body: Body(toggle),
    );
  }
}
