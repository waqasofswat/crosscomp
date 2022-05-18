import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class CreateChallenges extends StatefulWidget {
  CreateChallenges({Key? key}) : super(key: key);

  @override
  _CreateChallengesState createState() => _CreateChallengesState();
}

class _CreateChallengesState extends State<CreateChallenges> {
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
          "Create a Personal \nChallenges",
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
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Jon Opsahl",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: getProportionateScreenHeight(18),
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
                      "Enter the Name of a CrossComp Participant:",
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
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  onChanged: (txt) {
                    participantName = txt;
                  },
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  initialValue: participantName,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Name of Participant',
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
                    text: "Add Participant",
                    press: () {},
                    clr: kTextGreenColor,
                    isInfinity: true),
              ),
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              Container(
                color: Colors.grey[400],
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Enter the Name of this Challenge: ",
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
                            message:
                                "Do you want to Create Personal Challenge?"),
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
