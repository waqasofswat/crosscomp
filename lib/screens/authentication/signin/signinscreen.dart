import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  // const SignInScreen({Key? key}) : super(key: key);
  final Function toggle;

  SignInScreen(this.toggle);

  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Sign In"),
      ),
      body: SingleChildScrollView( reverse: false,child: Body(toggle)),
    );
  }
}
