import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class EventRecruit extends StatefulWidget {
  EventRecruit({Key? key}) : super(key: key);

  @override
  _EventRecruitState createState() => _EventRecruitState();
}

class _EventRecruitState extends State<EventRecruit> {
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
          "Available Shift",
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
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(18)),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: kSecondary2Color,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "4",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: getProportionateScreenHeight(50),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(18)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "OPEN POSITIONS",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(18)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "A CrossComp Judging Shift is available at:",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(18)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Andulka Gym",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Sunday",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "08/15/2021",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "1:00 - 3:00 pm",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DefaultButton(
                  text: "Yes, I'll take it!",
                  press: () {},
                  clr: kTextGreenColor,
                  isInfinity: true),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DefaultButton(
                  text: "Sorry, no can do.",
                  press: () {},
                  clr: kRedColor,
                  isInfinity: true),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DefaultButton(
                  text: "Send",
                  press: () {},
                  clr: kTextGreenColor,
                  isInfinity: true),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}
