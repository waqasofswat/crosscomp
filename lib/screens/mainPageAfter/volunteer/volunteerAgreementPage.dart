import 'dart:convert';

import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/volStatusPendingPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class VolunteerAgreementPage extends StatefulWidget {
  VolunteerAgreementPage({Key? key}) : super(key: key);

  @override
  _VolunteerAgreementPageState createState() => _VolunteerAgreementPageState();
}

class _VolunteerAgreementPageState extends State<VolunteerAgreementPage> {
  String userId = "";
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserId();
  }
  getUserId() async {
    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null)
        setState(() {
          userId = value;
          print("UserId  :  $value");
        });
    });

  }
  Future<Map<String, dynamic>> updateUserType() async {
    print("updateUserType");




    String url = mainApiUrl +
        "?profile_userType=true&User_ID=$userId&User_Type=volunteer";

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
            isLoading = false;
          });
        } else {
          try {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StatusPendingPage()));
          } catch (e) {
            print(e.toString());
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
          "Volunteer Agreement",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading?Center(child: Loading(),):
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(50)),
              DefaultButton(
                  text: "Download & Peview",
                  press: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => VolunteerSignUpPage()));
                  },
                  clr: kTextGreenColor,
                  isInfinity: true),
              SizedBox(height: getProportionateScreenHeight(15)),
              Text(
                "___ I have read the CrossComp Volunteer Agreement. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Text(
                "___ I understand and agree to the terms and conditions.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              DefaultButton(
                  text: "Submit",
                  press: () {
                    setState(() {
                      isLoading=true;
                    });
                    updateUserType();

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => VolunteerSignUpPage()));
                  },
                  clr: kTextGreenColor,
                  isInfinity: true),
              SizedBox(height: getProportionateScreenHeight(15)),
            ],
          ),
        ),
      ),
    );
  }
}
