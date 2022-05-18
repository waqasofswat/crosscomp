import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class CreateTeamPeerChallenges extends StatefulWidget {
  CreateTeamPeerChallenges({Key? key}) : super(key: key);

  @override
  _CreateTeamPeerChallengesState createState() =>
      _CreateTeamPeerChallengesState();
}

class _CreateTeamPeerChallengesState extends State<CreateTeamPeerChallenges> {
  String participantName = "";
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
          "Create a Team Challenges",
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
                color: Colors.grey[200],
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "BreckenFit Gym",
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
                color: Colors.grey[400],
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Select a Peer Group:",
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
              Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        "Level:",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: kTextGreenColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        "Territory:",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ],
              ),
              DefaultButton(
                  text: "Clear",
                  press: () {},
                  clr: kTextGreenColor,
                  isInfinity: true),
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: kSecondary2Color,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "0",
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
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              Container(
                color: Colors.grey[400],
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Enter the Name of this Team Challenge: ",
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
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  onChanged: (txt) {
                    participantName = txt;
                  },
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  initialValue: participantName,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Name of Challenge',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: kTextGreenColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: DefaultButton(
                    text: "Create",
                    press: () {
                      showDialog(
                        context: context,
                        builder: (_) => ConformDialog(
                            pressYes: () {},
                            pressNo: () {
                              Navigator.of(context).pop();
                            },
                            title: "Create Challenge",
                            message: "Do you want to Create Team Challenge?"),
                      );
                    },
                    clr: kRedColor,
                    isInfinity: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
