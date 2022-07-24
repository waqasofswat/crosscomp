import 'package:cross_comp/screens/mainPageAfter/professionals/affiliateProfPage.dart';
import 'package:cross_comp/screens/mainPageAfter/teams/volunteerTeamCaptain.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/assistantTrainers.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/coCaptain/volunteerCoCaptain.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/volunteerJudge/volunteerJudge.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'professionalFrag.dart';

class VolunteerFrag extends StatefulWidget {
  VolunteerFrag({Key? key}) : super(key: key);

  @override
  _VolunteerFragState createState() => _VolunteerFragState();
}

class _VolunteerFragState extends State<VolunteerFrag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VolunteerCoCaptain()));
                },
                child: Text(
                  "Co-Captain",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VolunteerTeamCaption()));
                },
                child: Text(
                  "Team Captain",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssistantTrainers()));
                },
                child: Text(
                  "Assistant Trainer",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VolunteerJudge()));
                },
                child: Text(
                  "Volunteer Judge",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Junior Commissioner",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {
                  HelperFunction.getProfSharedPreference().then((value) => {
                    if(value!){

                      Fluttertoast.showToast(msg: "You are already approved as Affilaite Professional. You can access the professional features from Navigation Menu")
                      // Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      //     builder: (context) => ProfessionalFrag()))
                     // return new ProfessionalFrag();
                    }else{
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AffliateProfPage()))
                    }
                  });

                },
                child: Text(
                  "Professional",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kTextGreenColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
            ],
          ),
        ),
      ),
    );
  }
}
