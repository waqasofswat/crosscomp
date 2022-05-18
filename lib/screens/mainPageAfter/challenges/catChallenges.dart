import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/challenges/createTeamChallenges.dart';
import 'package:cross_comp/screens/mainPageAfter/challenges/createTeamPeerChallenges.dart';
import 'package:cross_comp/screens/mainPageAfter/challenges/peerTeamChallengeScore.dart';
import 'package:cross_comp/screens/mainPageAfter/challenges/teamChallengeScore.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class CatChallenges extends StatefulWidget {
  final String catName;
  CatChallenges({Key? key, required this.catName}) : super(key: key);

  @override
  _CatChallengesState createState() => _CatChallengesState();
}

class _CatChallengesState extends State<CatChallenges> {
  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();

  List<Map<String, dynamic>> _gyms = [
    {"names": "Rival Gyms", "status": false, "isPersonal": true},
    {"names": "Riverside Gyms", "status": false, "isPersonal": false},
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
                              builder: (context) => TeamChallengeScore()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PeerTeamChallengeScore()));
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
                          title: "Remove ${widget.catName}",
                          message:
                              "Do you want to remove this ${widget.catName} Challenge"),
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
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "${widget.catName} Challenges",
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
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "BreckenFit ${widget.catName}",
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
              ),
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              Container(
                height: _gyms.length * 50.0,
                child: AnimatedList(
                  key: listKeyK,
                  initialItemCount: _gyms.length,
                  itemBuilder: (context, index, animation) {
                    return animatedTileO(
                        context, index, animation, _gyms); // Refer step 3
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
                              builder: (context) => CreateTeamChallenges()));
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
                                  CreateTeamPeerChallenges()));
                    },
                    clr: kTextGreenColor,
                    isInfinity: true),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: DefaultButton(
                    text: "Return to My Challenges",
                    press: () {
                      Navigator.of(context).pop();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             CreatePeerChallenges()));
                    },
                    clr: kPrimaryColor,
                    isInfinity: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
