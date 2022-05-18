import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/challenges/catChallenges.dart';
import 'package:cross_comp/screens/mainPageAfter/challenges/createChallenges.dart';
import 'package:cross_comp/screens/mainPageAfter/challenges/createPeerChallenges.dart';
import 'package:cross_comp/screens/mainPageAfter/challenges/peerChallengeScore.dart';
import 'package:cross_comp/screens/mainPageAfter/challenges/personalChallengeScore.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class MyChallenges extends StatefulWidget {
  MyChallenges({Key? key}) : super(key: key);

  @override
  _MyChallengesState createState() => _MyChallengesState();
}

class _MyChallengesState extends State<MyChallenges> {
  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> listKeyM = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> _personal = [
    {"names": "Gym Buddies", "type": "S", "status": false, "isPersonal": true},
    {
      "names": "Riverside City Peers",
      "type": "S",
      "status": false,
      "isPersonal": false
    },
  ];

  Widget animatedTileO(BuildContext context, int index, animation,
      List<Map<String, dynamic>> item) {
    Map<String, dynamic> part = item[index];

    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return participantsRow(animation, part, textStyle);
  }

  SlideTransition participantsRow(
      animation, Map<String, dynamic> item, TextStyle textStyle) {
    bool isStatus = item["status"];
    bool isPersonal = item["isPersonal"];
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    child: isStatus
                        ? Text(
                            "*",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: kRedColor),
                          )
                        : Container()),
              ),
              Expanded(
                flex: 14,
                child: GestureDetector(
                  onTap: () {
                    if (isPersonal) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonalChallengeScore()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PeerChallengeScore()));
                    }
                  },
                  child: Text(
                    item["names"].toString(),
                    textAlign: TextAlign.start,
                    style: textStyle,
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => ConformDialog(
                          pressYes: () {},
                          pressNo: () {
                            Navigator.of(context).pop();
                          },
                          title: "Remove Challenge",
                          message:
                              "Do you want to remove this Personal Challenge"),
                    );
                  },
                  child: Image.asset(
                    "assets/images/red_cross.png",
                    height: getProportionateScreenHeight(15),
                    width: getProportionateScreenWidth(15),
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
      ),
    );
  }

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
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  backgroundColor: kPrimaryColor,
                  bottom: TabBar(
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Center(
                          child: Text(
                            "Personal",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenWidth(15)),
                          ),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Text(
                            "Team",
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
                      child: Column(
                        children: [
                          Container(
                            height: _personal.length * 50.0,
                            child: AnimatedList(
                              key: listKeyK,
                              initialItemCount: _personal.length,
                              itemBuilder: (context, index, animation) {
                                return animatedTileO(context, index, animation,
                                    _personal); // Refer step 3
                              },
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: DefaultButton(
                                text: "Create a Challenge",
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateChallenges()));
                                },
                                clr: kTextGreenColor,
                                isInfinity: true),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: DefaultButton(
                                text: "Create a Peer Challenge",
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreatePeerChallenges()));
                                },
                                clr: kTextGreenColor,
                                isInfinity: true),
                          ),
                        ],
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
                                          builder: (context) => CatChallenges(
                                                catName: 'Community',
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
                                          builder: (context) => CatChallenges(
                                                catName: 'City',
                                              )));
                                },
                                child: Text(
                                  "My City Team",
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
                                          builder: (context) => CatChallenges(
                                                catName: 'County',
                                              )));
                                },
                                child: Text(
                                  "My County Team",
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
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => CreateTeam(
                                  //               teamName: "High School",
                                  //             )));
                                },
                                child: Text(
                                  "My State Team",
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
                                          builder: (context) => CatChallenges(
                                                catName: 'Country',
                                              )));
                                },
                                child: Text(
                                  "My Country Team",
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
                                          builder: (context) => CatChallenges(
                                                catName: 'Family',
                                              )));
                                },
                                child: Text(
                                  "My Family Team",
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
                                          builder: (context) => CatChallenges(
                                                catName: 'Gym',
                                              )));
                                },
                                child: Text(
                                  "My Gym Team",
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
                                          builder: (context) => CatChallenges(
                                                catName: 'Gym Brand',
                                              )));
                                },
                                child: Text(
                                  "My Gym Brand Team",
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
                                          builder: (context) => CatChallenges(
                                                catName: 'Faith Group',
                                              )));
                                },
                                child: Text(
                                  "My Faith Group Team",
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
                                          builder: (context) => CatChallenges(
                                                catName: 'Faith',
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

class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  @override
  OutlinedBorder resolve(Set<MaterialState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    );
  }
}
