import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/trainings/freeEventTrainingNavigation.dart';
import 'package:cross_comp/screens/mainpageBefore/webPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'freeTrainings.dart';

class FreeEventTrainingReservation extends StatefulWidget {
  FreeEventTrainingReservation({Key? key}) : super(key: key);

  @override
  _FreeEventTrainingReservationState createState() =>
      _FreeEventTrainingReservationState();
}

class _FreeEventTrainingReservationState
    extends State<FreeEventTrainingReservation> {
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
          "Training Reservation",
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
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "Andulka Park",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FreeEventTrainingNavigation()));
                  },
                  child: Column(
                    children: [
                      Text(
                        "3542 Central Ave",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          color: kTextGreenColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "Riverside, CA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          color: kTextGreenColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "92507",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          color: kTextGreenColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(25)),
                Text(
                  "Cost: FREE!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(25),
                    color: kRedColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "Sunday",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "August 15,2021",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "3:00 - 5:00 pm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                DefaultButton(
                    text: "Change",
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FreeTrainings()));
                    },
                    clr: kTextGreenColor,
                    isInfinity: false),
                SizedBox(height: getProportionateScreenHeight(15)),
                DefaultButton(
                    text: "INSTRUCTION",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebPage(
                                  "http://www.crosscomps.com/instructions")));
                    },
                    clr: kTextColor,
                    isInfinity: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
