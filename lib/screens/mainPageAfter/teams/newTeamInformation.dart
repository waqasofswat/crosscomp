import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'manageTeams.dart';

class NewTeamInformation extends StatefulWidget {
  NewTeamInformation({Key? key}) : super(key: key);

  @override
  _NewTeamInformationState createState() => _NewTeamInformationState();
}

class _NewTeamInformationState extends State<NewTeamInformation> {
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
          "New Team Information",
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
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Mentone SDA Church",
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Street Address",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "City",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "State",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Postal Code",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              Container(
                color: Colors.grey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Select or Create a Category Team:",
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Category Team",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              DefaultButton(
                  text: "Submit",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageTeam(
                                  secondTitle: "Mentone SDA Church",
                                )));
                  },
                  clr: kTextGreenColor,
                  isInfinity: false),
            ],
          ),
        ),
      ),
    );
  }
}
