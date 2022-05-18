import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/homePage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class StatusPendingPage extends StatefulWidget {
  StatusPendingPage({Key? key}) : super(key: key);

  @override
  _StatusPendingPageState createState() => _StatusPendingPageState();
}

class _StatusPendingPageState extends State<StatusPendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Status Pending",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(50)),
              Text(
                "You have completed the process for becoming a Volunteer Affiliate with CrossComps.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Text(
                "Upon approval, we will send you a link for up-grading your App.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              DefaultButton(
                  text: "Menu",
                  press: () {
                    HelperFunction.saveVolSharedPreference(true);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) => false);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => VolunteerSignUpPage()));
                  },
                  clr: kTextGreenColor,
                  isInfinity: true),
              SizedBox(height: getProportionateScreenHeight(15)),
            ],
          ),
        ),
      ),
    );
  }
}
