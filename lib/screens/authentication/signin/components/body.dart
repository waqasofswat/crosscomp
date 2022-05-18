import 'package:cross_comp/component/default_button.dart';
import 'sign_in_form.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Function toggle;

  Body(this.toggle);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(150),
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  SignForm(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  DefaultButton(
                    isInfinity: false,
                    clr: kPrimaryColor,
                    text: "Sign Up",
                    press: () {
                      toggle();
                      // Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
