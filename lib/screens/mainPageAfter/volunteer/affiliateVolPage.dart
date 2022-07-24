import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/volunteerSignUpPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class AffiliateVolPage extends StatefulWidget {
  AffiliateVolPage({Key? key}) : super(key: key);

  @override
  _AffiliateVolPageState createState() => _AffiliateVolPageState();
}

class _AffiliateVolPageState extends State<AffiliateVolPage> {
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
          "Affiliate",
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
                "As a Participant in CrossComps,",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "you are eligible to Affiliate with our fitness network as a:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              DefaultButton(
                  text: "Volunteer",
                  size: 14.0,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VolunteerSignUpPage(isSecondStep: false,)));
                  },
                  clr: kTextGreenColor,
                  isInfinity: true),
              SizedBox(height: getProportionateScreenHeight(50)),
              Text(
                "If you become a Volunteer,",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "you will be eligible to Affiliate with our fitness network as a Professional, as well.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}
