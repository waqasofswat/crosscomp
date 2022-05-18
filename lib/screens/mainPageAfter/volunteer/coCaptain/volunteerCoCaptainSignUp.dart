import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/coCaptain/volunteerAllCoCaptains.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class VolunteerCoCaptainSignUp extends StatefulWidget {
  VolunteerCoCaptainSignUp({Key? key}) : super(key: key);

  @override
  _VolunteerCoCaptainSignUpState createState() =>
      _VolunteerCoCaptainSignUpState();
}

class _VolunteerCoCaptainSignUpState extends State<VolunteerCoCaptainSignUp> {
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
          "Co-Captain Sign-Up",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Mentone SDA Church",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: getProportionateScreenHeight(20),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Mark Foster",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              SizedBox(height: getProportionateScreenHeight(50)),
              DefaultButton(
                  text: "Sign-Up",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VolunteerAllCoCaptains()));
                  },
                  clr: kTextGreenColor,
                  isInfinity: false),
            ],
          ),
        ),
      ),
    );
  }
}
