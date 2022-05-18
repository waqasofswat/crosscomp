import 'dart:convert';

import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/professionalJudge/professionalJudgeSchedule.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfessionalJudgeSignUp extends StatefulWidget {
  final Map<String, String> mapList;
  ProfessionalJudgeSignUp({required this.mapList}) ;

  @override
  _ProfessionalJudgeSignUpState createState() =>
      _ProfessionalJudgeSignUpState();
}

class _ProfessionalJudgeSignUpState extends State<ProfessionalJudgeSignUp> {
  bool isLoading=false;
  bool isError=false;
  String UserId='';
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

          UserId = value;
          print("UserId  :  $value");

        });
    });
  }
  Future<Map<String, dynamic>> saveAppointment() async {
    print("saveAppointment");

    String url = mainApiUrl + "?add_judges_appointments=true&J_ID=$UserId&EF_ID=${widget.mapList['id']}&Type=${widget.mapList['type']}&Day=${widget.mapList['day']}&Date=${widget.mapList['date']}&Timing=${widget.mapList['timing']}&status=3";

    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      if (response.body.toString().contains("Failure")) {
        print("response Failed");
        setState(() {
          isLoading = false;
        });
      } else {
        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status'] == "failed") {
          if(map['val'] =="exists"){
            setState(() {

              isError = true;
              isLoading = false;
            });
          }else
          setState(() {

            isLoading = false;
          });
        } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    ProfessionalJudgeSchedule()));

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
          "Judge Sign Up",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading ? Center(child: Loading()) :
      SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(

              children: [
                SizedBox(height: getProportionateScreenHeight(30)),
                Container(
                  child: isError?
                  Column(children: [
                    Text(
                      "You Can't Sign-Up to same facility Again",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: kRedColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                  ],):Container(),
                ),
                Text(
                  widget.mapList["title"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  widget.mapList["street"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: kTextGreenColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  widget.mapList["city"].toString()+", "+widget.mapList["state"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: kTextGreenColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  widget.mapList["postalCode"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: kTextGreenColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  widget.mapList["manager"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                SizedBox(height: getProportionateScreenHeight(15)),
                SizedBox(height: getProportionateScreenHeight(15)),
                SizedBox(height: getProportionateScreenHeight(15)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultButton(
                            text: "SIGN-UP",
                            press: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => ConformDialog(
                                      pressYes: () {

                                        Navigator.of(context).pop();
                                       setState(() {
                                         isLoading=true;
                                         saveAppointment();
                                       });
                                      },
                                      pressNo: () {
                                        Navigator.of(context).pop();
                                      },
                                      title: "Appointment",
                                      message: "Are you Sure"));


                            },
                            clr: kTextGreenColor,
                            isInfinity: false),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        DefaultButton(
                            text: "Return to Map",
                            press: () {
                              Navigator.pop(context);
                            },
                            clr: kPrimaryColor,
                            isInfinity: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
