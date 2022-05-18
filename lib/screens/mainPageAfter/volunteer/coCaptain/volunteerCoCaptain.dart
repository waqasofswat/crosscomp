import 'package:cross_comp/screens/mainPageAfter/volunteer/coCaptain/volunteerCoCaptainSignUp.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class VolunteerCoCaptain extends StatefulWidget {
  VolunteerCoCaptain({Key? key}) : super(key: key);

  @override
  _VolunteerCoCaptainState createState() => _VolunteerCoCaptainState();
}

class _VolunteerCoCaptainState extends State<VolunteerCoCaptain> {
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
          "Co-Captain",
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
        child: Container(
          child: Center(
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
                              builder: (context) =>
                                  VolunteerCoCaptainSignUp()));
                    },
                    child: Text(
                      "My Family Team",
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
                              builder: (context) =>
                                  VolunteerCoCaptainSignUp()));
                    },
                    child: Text(
                      "My Gym Team",
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
                              builder: (context) =>
                                  VolunteerCoCaptainSignUp()));
                    },
                    child: Text(
                      "My Faith Team",
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
                              builder: (context) =>
                                  VolunteerCoCaptainSignUp()));
                    },
                    child: Text(
                      "My Company Team",
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
                              builder: (context) =>
                                  VolunteerCoCaptainSignUp()));
                    },
                    child: Text(
                      "My Company Team",
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
                              builder: (context) =>
                                  VolunteerCoCaptainSignUp()));
                    },
                    child: Text(
                      "My College Team",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: kTextGreenColor,
                        fontSize: getProportionateScreenHeight(25),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
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
