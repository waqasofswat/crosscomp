import 'package:cross_comp/screens/mainPageAfter/volunteer/optiHealthPledgePage.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/volunteerAgreementPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class VolunteerSignUpPage extends StatefulWidget {
 final bool isSecondStep;
  VolunteerSignUpPage({Key? key, required bool this.isSecondStep}) : super(key: key);

  @override
  _VolunteerSignUpPageState createState() => _VolunteerSignUpPageState();
}

class _VolunteerSignUpPageState extends State<VolunteerSignUpPage> {
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
          "Volunteer Sign-Up",
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
                "To become a Volunteer Affiliate with CrossComps, simply complete the 2 items below:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
          if(widget.isSecondStep)...[
              Text(
                "OptiHealth Pledge",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: widget.isSecondStep?kPrimaryColor: kTextGreenColor,
                  fontSize: getProportionateScreenHeight(25),
                  fontWeight: FontWeight.w900,
                ),
              ),
              ]else...[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OptiHealthPledgePage()));
              },
              child: Text(
                "OptiHealth Pledge",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: widget.isSecondStep?kPrimaryColor: kTextGreenColor,
                  fontSize: getProportionateScreenHeight(25),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
              SizedBox(height: getProportionateScreenHeight(15)),
              if(widget.isSecondStep)...[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VolunteerAgreementPage()));
                  },
                  child: Text(
                    "Volunteer Agreement",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: widget.isSecondStep?kTextGreenColor:kPrimaryColor ,
                      fontSize: getProportionateScreenHeight(25),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]else...[
                Text(
                  "Volunteer Agreement",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ]

            ],
          ),
        ),
      ),
    );
  }
}
