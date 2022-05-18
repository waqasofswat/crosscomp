import 'dart:convert';

import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/component/okDialog.dart';
import 'package:cross_comp/screens/mainPageAfter/teams/joinATeamSubCat.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class JoinATeam extends StatefulWidget {
  JoinATeam({Key? key}) : super(key: key);

  @override
  _JoinATeamState createState() => _JoinATeamState();
}

class _JoinATeamState extends State<JoinATeam> {
  String UserId = "";
  bool isLoading=false;

  getUserId() async {

    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null)
        setState(() {
          UserId = value;
          print("UserId  :  $value");

          getAllTeams();
        });
    });
  }
  Future<Map<String, dynamic>> getAllTeams() async {
    print("getTeamScoresMethod");


    String url = getAllTeamsUrl + "?getAllTeams=true&userID=$UserId";

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

            // if(
            // map["team_Details"][0]["TeamName"].toString()!= null &&
            //     map["team_Details"][0]["TeamAddress"].toString()!= null &&
            //     map["team_ages"][0]["AVG(LatestScore)"].toString()!= null &&
            //     map["team_score"][0]["ScoreDate"].toString()!= null &&
            //     map["team_counts"][0]["TeamCounts"].toString()!= null
            // ){
            //
            //   teamName=map["team_Details"][0]["TeamName"].toString();
            //   teamScore=double. parse(double.parse(map["team_ages"][0]["AVG(LatestScore)"].toString()).toStringAsFixed(2)).toString();
            //   teamAddress=map["team_Details"][0]["TeamAddress"].toString();
            //   teamDate=map["team_score"][0]["ScoreDate"].toString();
            //   teamParticipant=map["team_counts"][0]["TeamCounts"].toString();
            // }
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
   // getUserId();
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
          "Join a Team",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading ?Center(child: Loading()):
      SingleChildScrollView(
        child:
      Center(
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Select a Category:",
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
                  ],
                ),
              ),
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              JoinATeamSubCat(teamName: "Family")));
                },
                child: Text(
                  "Family Team",
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
                              JoinATeamSubCat(teamName: "Gym")));
                },
                child: Text(
                  "Gym Team",
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
                              JoinATeamSubCat(teamName: "Faith")));
                },
                child: Text(
                  "Faith Team",
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
                              JoinATeamSubCat(teamName: "Company")));
                },
                child: Text(
                  "Company Team",
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
                              JoinATeamSubCat(teamName: "Occupation")));
                },
                child: Text(
                  "Occupation Team",
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
                              JoinATeamSubCat(teamName: "High School")));
                },
                child: Text(
                  "High School Team",
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
                              JoinATeamSubCat(teamName: "College")));
                },
                child: Text(
                  "College Team",
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
                          builder: (context) => JoinATeamSubCat(
                              teamName: "Professional School")));
                },
                child: Text(
                  "Professional School Team",
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
                              JoinATeamSubCat(teamName: "Military")));
                },
                child: Text(
                  "Military Team",
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
            ],
          ),
        ),
      ),
    );
  }
}
