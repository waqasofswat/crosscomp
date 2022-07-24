import 'package:cross_comp/component/default_button.dart';
import 'sign_up_form.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Function toggle;

  Body(this.toggle);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
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
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  Image.asset(
                    "assets/images/app_logo.jpg",
                    height: getProportionateScreenHeight(200),
                    width: getProportionateScreenWidth(200),
                  ),
                  Text(
                    "Sign-Up and get your first CrossComp for FREE!",
                    textAlign: TextAlign.center,
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
                    "Already have an account? ",
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
                    text: "Sign In",
                    press: () {
                      toggle();
                      // Navigator.pushNamed(context, SignInScreen.routeName);
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
