import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'newTeamInformation.dart';

class CreateTeam extends StatefulWidget {
  final String teamName;
  CreateTeam({Key? key, required this.teamName}) : super(key: key);

  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  String text = "";
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
          "Create a ${widget.teamName} Team",
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
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Enter the Name of a new local ${widget.teamName} Group Team",
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
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  onChanged: (txt) {
                    text = txt;
                  },
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  initialValue: text,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Name of local ${widget.teamName} Group',
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
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              SizedBox(height: getProportionateScreenHeight(15)),
              SizedBox(height: getProportionateScreenHeight(15)),
              SizedBox(height: getProportionateScreenHeight(15)),
              DefaultButton(
                  text: "Create",
                  press: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewTeamInformation()));
                  },
                  clr: kRedColor,
                  isInfinity: false),
              SizedBox(height: getProportionateScreenHeight(15)),
            ],
          ),
        ),
      ),
    );
  }
}
