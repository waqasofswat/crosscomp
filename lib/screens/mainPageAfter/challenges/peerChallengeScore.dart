import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../sharePage.dart';

class PeerChallengeScore extends StatefulWidget {
  PeerChallengeScore({Key? key}) : super(key: key);

  @override
  _PeerChallengeScoreState createState() => _PeerChallengeScoreState();
}

class _PeerChallengeScoreState extends State<PeerChallengeScore> {
  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> _cocaptains = [
    {"name": "High School", "total_scores": "121.2", "isGreen": false},
    {"name": "Jon Opsahl", "total_scores": "104.3", "isGreen": true},
    {"name": "Low Score", "total_scores": "57.6", "isGreen": false},
    {"name": "Placement", "total_scores": "14th", "isGreen": true},
    {"name": "Percentile", "total_scores": "84.1", "isGreen": true},
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
    bool isStatus = item["isGreen"];
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 14,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SharePage(
                                  map: item,
                                )));
                  },
                  child: Text(
                    item["name"].toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color: isStatus ? kTextGreenColor : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => FacilityCheckIn()));
                  },
                  child: Text(
                    item["total_scores"].toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color: isStatus ? kTextGreenColor : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              // Expanded(
              //   flex: 2,
              //   child: GestureDetector(
              //     onTap: () {
              //       showDialog(
              //         context: context,
              //         builder: (_) => ConformDialog(
              //             pressYes: () {},
              //             pressNo: () {
              //               Navigator.of(context).pop();
              //             },
              //             title: "Remove User",
              //             message: "Do you want to remove this person"),
              //       );
              //     },
              //     child: Image.asset(
              //       "assets/images/red_cross.png",
              //       height: getProportionateScreenHeight(15),
              //       width: getProportionateScreenWidth(15),
              //     ),
              //   ),
              // ),
              // Expanded(flex: 1, child: Container()),
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
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Challenges Scores",
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
                color: Colors.grey[400],
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Riverside City Peers",
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
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "August 9, 2021",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black87,
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
              Container(
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Riverside City",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: kRedColor,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Males",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: kRedColor,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "59.4 - 63.04",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: kRedColor,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.normal,
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 14,
                      child: Text(
                        "# of Participants",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "82",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
              ),
              Container(
                height: _cocaptains.length * 50.0,
                child: AnimatedList(
                  key: listKeyK,
                  initialItemCount: _cocaptains.length,
                  itemBuilder: (context, index, animation) {
                    return animatedTileO(
                        context, index, animation, _cocaptains); // Refer step 3
                  },
                ),
              ),
              DefaultButton(
                  text: "Share",
                  press: () {},
                  clr: kPrimaryColor,
                  isInfinity: false),
              Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(20)),
                child: DefaultButton(
                    text: "Return to My Challenges",
                    press: () {
                      Navigator.of(context).pop();
                    },
                    clr: kPrimaryColor,
                    isInfinity: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
