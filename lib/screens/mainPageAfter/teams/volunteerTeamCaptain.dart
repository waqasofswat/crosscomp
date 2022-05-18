import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'createTeam.dart';
import 'manageTeamsCat.dart';

class VolunteerTeamCaption extends StatefulWidget {
  VolunteerTeamCaption({Key? key}) : super(key: key);

  @override
  _VolunteerTeamCaptionState createState() => _VolunteerTeamCaptionState();
}

class _VolunteerTeamCaptionState extends State<VolunteerTeamCaption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(
                height: getProportionateScreenHeight(170),
                child: AppBar(
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  backgroundColor: kPrimaryColor,
                  title: Text(
                    "Team Captain",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenHeight(18),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  bottom: TabBar(
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Center(
                          child: Text(
                            "Sub-Category Teams",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenWidth(15)),
                          ),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Text(
                            "Category Teams",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenWidth(15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    Container(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateTeam(
                                                teamName: "Family",
                                              )));
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
                              SizedBox(
                                  height: getProportionateScreenHeight(15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateTeam(
                                                teamName: "Gym",
                                              )));
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
                              SizedBox(
                                  height: getProportionateScreenHeight(15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateTeam(
                                                teamName: "Faith",
                                              )));
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
                              SizedBox(
                                  height: getProportionateScreenHeight(15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateTeam(
                                                teamName: "Company",
                                              )));
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
                              SizedBox(
                                  height: getProportionateScreenHeight(15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateTeam(
                                                teamName: "Occupation",
                                              )));
                                },
                                child: Text(
                                  "My Occupation Team",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getProportionateScreenHeight(25),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateTeam(
                                                teamName: "College",
                                              )));
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
                              SizedBox(
                                  height: getProportionateScreenHeight(15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateTeam(
                                                teamName: "High School",
                                              )));
                                },
                                child: Text(
                                  "My High School Team",
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

                    // second tab bar viiew widget
                    Container(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ManageTeamCat(
                                                secondTitle:
                                                    'Seventh-day Adventists',
                                              )));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Seventh-day Adventists",
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize:
                                          getProportionateScreenHeight(25),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
