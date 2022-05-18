import 'dart:convert';

import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/component/okDialog.dart';
import 'package:cross_comp/screens/mainPageAfter/teams/teamStanding.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyTeamScore extends StatefulWidget {
  final bool isJoined;
  final String teamID;
  final String teamType;
  MyTeamScore({Key? key, required this.isJoined, required this.teamID, required this.teamType}) : super(key: key);

  @override
  _MyTeamScoreState createState() => _MyTeamScoreState();
}

class _MyTeamScoreState extends State<MyTeamScore> {
  bool isLoading=true;
  String teamName='Team Name';
  String teamScore='00.0';
  String teamAddress='00.0';
  String teamDate='2021-01-01';
  String teamParticipant='2021-01-01';

  Future<Map<String, dynamic>> getTeamScoresMethod() async {
    print("getTeamScoresMethod");


    String url = mainApiUrl + "?getTeamScoresUrl=true&teamID=${widget.teamID}&teamType=${widget.teamType}";

    print(url);
    final response = await http.get(Uri.parse(url));
    // Map<String, String> header = {"Content-type": "multipart/form-data"};
    // final response = await http.post(
    //   Uri.parse(getScoresUrl),
    //   headers: header,
    //   body: {'getUser_Scores': "true", 'userId': UserId},
    // );

    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      if (response.body.toString().contains("Failure")) {
        print("response Failed");
        setState(() {
          // _loading = false;
          isLoading = false;
          // progress?.dismiss();
        });
      } else {
        // import 'dart:convert';

        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status'] == "failed") {
          setState(() {
            // _btnController.error();
            // progress?.dismiss();
            isLoading = false;
          });
        } else {

          try{

          if(
          map["team_Details"][0]["TeamName"].toString()!= null &&
          map["team_Details"][0]["TeamAddress"].toString()!= null &&
          map["team_ages"][0]["AVG(LatestScore)"].toString()!= null &&
          map["team_score"][0]["ScoreDate"].toString()!= null &&
          map["team_counts"][0]["TeamCounts"].toString()!= null
          ){

            teamName=map["team_Details"][0]["TeamName"].toString();
            teamScore=double. parse(double.parse(map["team_ages"][0]["AVG(LatestScore)"].toString()).toStringAsFixed(2)).toString();
            teamAddress=map["team_Details"][0]["TeamAddress"].toString();
            teamDate=map["team_score"][0]["ScoreDate"].toString();
            teamParticipant=map["team_counts"][0]["TeamCounts"].toString();
          }
          }catch(e){print(e.toString());
          showDialog(
              context: context,
              builder: (_) => OkDialog(
                  pressOk: () {

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },

                  title: "Error",
                  message: "Sorry No Records in database"));
          }
          setState(() {
            isLoading = false;
          });
        }

        print("response Success");


      }
      return json.decode(response.body.toString());
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeamScoresMethod();
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
          "My Team Score",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading?
      Center(child: Loading()):
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                teamName,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(25),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                teamParticipant,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: kTextGreenColor,
                  fontSize: getProportionateScreenHeight(15),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                teamAddress,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(15),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Text(
                "Total CrossComp Score",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(15),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                teamScore,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: kTextGreenColor,
                  fontSize: getProportionateScreenHeight(75),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              Padding(
                padding: EdgeInsets.all(25.0),
                child: DefaultButton(
                    text: "Team Standing",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TeamStanding(teamCategory: widget.teamType,)));
                    },
                    clr: kPrimaryColor,
                    isInfinity: true),
              ),
              DefaultButton(
                  text: "Share",
                  press: () {},
                  clr: kPrimaryColor,
                  isInfinity: false),
              Padding(
                padding: EdgeInsets.all(25.0),
                child: DefaultButton(
                    text: "Return to My Team",
                    press: () {
                      Navigator.of(context).pop();
                    },
                    clr: kPrimaryColor,
                    isInfinity: true),
              ),
              Padding(
                padding: EdgeInsets.all(25.0),
                child: widget.isJoined
                    ? DefaultButton(
                        text: "Un-Join",
                        press: () {
                          Navigator.of(context).pop();
                        },
                        clr: kRedColor,
                        isInfinity: true)
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
