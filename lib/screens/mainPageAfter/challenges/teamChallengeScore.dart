import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../sharePage.dart';

class TeamChallengeScore extends StatefulWidget {
  TeamChallengeScore({Key? key}) : super(key: key);

  @override
  _TeamChallengeScoreState createState() => _TeamChallengeScoreState();
}

class _TeamChallengeScoreState extends State<TeamChallengeScore> {
  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> _cocaptains = [
    {
      "name": "Fitness Mania",
      "age": "60.05",
      "date": "July 18,2021",
      "status": "Current",
      "statustype": "1",
      "total_scores": "92.3",
      "shuttle": "102.5",
      "squats": "94.5",
      "legRise": "113.3",
      "pushups": "106.7",
      "isGreen": false
    },
    {
      "name": "BreckenFit",
      "age": "60.05",
      "date": "July 18,2021",
      "status": "Current",
      "statustype": "1",
      "total_scores": "89.1",
      "shuttle": "102.5",
      "squats": "90.5",
      "legRise": "113.3",
      "pushups": "106.7",
      "isGreen": true
    },
    {
      "name": "24-Hour Fitness",
      "age": "60.05",
      "date": "July 18,2021",
      "status": "Current",
      "statustype": "1",
      "total_scores": "82.8",
      "shuttle": "98.5",
      "squats": "90.5",
      "legRise": "103.3",
      "pushups": "96.7",
      "isGreen": false
    },
    {
      "name": "Planet Fitness",
      "age": "60.05",
      "date": "July 18,2021",
      "status": "Current",
      "statustype": "1",
      "total_scores": "71.5",
      "shuttle": "95.5",
      "squats": "90.5",
      "legRise": "100.3",
      "pushups": "93.7",
      "isGreen": false
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
                      color: isStatus ? kTextGreenColor : kPrimaryColor,
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
                      color: isStatus ? kTextGreenColor : kPrimaryColor,
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
          "Team Challenges Scores",
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
                color: Colors.grey,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Rival Gyms",
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
              SizedBox(height: getProportionateScreenHeight(50)),
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
