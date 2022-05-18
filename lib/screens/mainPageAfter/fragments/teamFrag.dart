import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/teams/joinATeam.dart';
import 'package:cross_comp/screens/mainPageAfter/teams/myTeamScore.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class TeamFrag extends StatefulWidget {
  TeamFrag({Key? key}) : super(key: key);

  @override
  _TeamFragState createState() => _TeamFragState();
}

class _TeamFragState extends State<TeamFrag> {
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
                height: getProportionateScreenHeight(50),
                child: AppBar(
                  backgroundColor: kPrimaryColor,
                  bottom: TabBar(
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text(
                          "Standard",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(18)),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Custom",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(18)),
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
                                          builder: (context) => MyTeamScore(
                                            teamID: "1",
                                                teamType: "CommunityTeam",
                                                isJoined: false,
                                              )));
                                },
                                child: Text(
                                  "My Community Team",
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
                                          builder: (context) =>
                                              MyTeamScore(isJoined: false, teamID: "21",
                                                  teamType: "CityTeam",)));
                                },
                                child: Text(
                                  "My City Team",
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
                                          builder: (context) =>
                                              MyTeamScore(isJoined: false
                                              ,teamID: "11",teamType: "CountyTeam",)));
                                },
                                child: Text(
                                  "My County Team",
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
                                          builder: (context) =>
                                              MyTeamScore(isJoined: false
                                              ,teamID: "2",teamType: "StateTeam",)));
                                },
                                child: Text(
                                  "My State Team",
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
                                          builder: (context) =>
                                              MyTeamScore(isJoined: false,teamID: "1",teamType: "CountryTeam",)));
                                },
                                child: Text(
                                  "My Country Team",
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
                                          builder: (context) =>
                                              MyTeamScore(isJoined: false,teamID: "1",teamType: "ContinentTeam",)));
                                },
                                child: Text(
                                  "My Continent Team",
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
                                          builder: (context) =>
                                              MyTeamScore(isJoined: false,teamID: "1",teamType: "WorldTeam",)));
                                },
                                child: Text(
                                  "My World Team",
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
                                          builder: (context) => MyTeamScore(
                                                isJoined: true,
                                            teamID: "1",
                                            teamType: "FamilyTeam",
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
                                          builder: (context) =>
                                              MyTeamScore(isJoined: true,teamID: "1",teamType: "GymTeam",)));
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
                                          builder: (context) => MyTeamScore(
                                                isJoined: true,
                                            teamID: "1",
                                            teamType: "FaithTeam",
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
                              DefaultButton(
                                  text: "Join a Team",
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => JoinATeam()));
                                  },
                                  clr: kTextGreenColor,
                                  isInfinity: false),
                              SizedBox(
                                  height: getProportionateScreenHeight(15)),
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
