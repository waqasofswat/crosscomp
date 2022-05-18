import 'dart:convert';

import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FacilityRecruitAssistant extends StatefulWidget {
  Map<String,dynamic> mapList;
  String title;
  FacilityRecruitAssistant({Key? key,required this.mapList,required this.title}) : super(key: key);

  @override
  _FacilityRecruitAssistantState createState() =>
      _FacilityRecruitAssistantState();
}

class _FacilityRecruitAssistantState extends State<FacilityRecruitAssistant> {
  String UserId = "";
  bool isLoading=false;
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


  Future<Map<String, dynamic>> saveAssistance() async {
    print("saveAssistance");

    String type="event";

      type="facility";


      String id=widget.mapList["ef_id"];
      print("id is $id");
      String day=widget.mapList["day"];
    print("day is $day");
      String date=widget.mapList["date"];
    print("date is $date");
      String selectedTimings=widget.mapList["tmng"];
    print("selectedTimings is $selectedTimings");
    //selectedTimings=Uri.encodeComponent(selectedTimings);
     String url = mainApiUrl + "?add_assistance_trainer=true&User_ID=$UserId&ef_id=$id&day=$day&date=$date&timing=$selectedTimings&type=$type";

    //print(url);
    final response = await http.get(Uri.parse(url));
    // Map<String, String> header = {"Content-type": "multipart/form-data"};
    // final response = await http.post(
    //   Uri.parse(mainApiUrl),
    //   //  headers: header,
    //   body: {
    //     'add_assistance_trainer': "true",
    //     'User_ID': UserId,
    //     'ef_id': widget.mapList["ef_id"],
    //     'day': widget.mapList["day"],
    //     'date': widget.mapList["currDate"],
    //     'timing': widget.mapList["tmng"],
    //     'type': type,
    //     'isFree': "0",
    //     'checkedIn': "0"
    //   },
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
          try{

            String id= map["id"].toString();
            print("Reservation id : $id");
            setState(() {
              Navigator.of(context).pop();
            });


          }catch(e){
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
          "Available Shift",
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
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(18)),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: kSecondary2Color,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "4",
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
            SizedBox(height: getProportionateScreenHeight(18)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "OPEN POSITIONS",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(18)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "A CrossComp Judging Shift is available at:",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(18)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                widget.mapList["day"],
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                widget.mapList["date"],
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                widget.mapList["tmng"],
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: getProportionateScreenHeight(18),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DefaultButton(
                  text: "Yes, I'll take it!",
                  press: () {
                    showDialog(
                        context: context,
                        builder: (_) => ConformDialog(
                            pressYes: () {

                              Navigator.of(context).pop();
                              setState(() {
                                isLoading=true;
                                saveAssistance();
                              });
                            },
                            pressNo: () {
                              Navigator.of(context).pop();
                            },
                            title: "Appointment",
                            message: "Are you Sure"));
                  },
                  clr: kTextGreenColor,
                  isInfinity: true),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DefaultButton(
                  text: "Sorry, no can do.",
                  press: () {
                    Navigator.of(context).pop();
                  },
                  clr: kRedColor,
                  isInfinity: true),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DefaultButton(
                  text: "Send",
                  press: () {
                    showDialog(
                        context: context,
                        builder: (_) => ConformDialog(
                            pressYes: () {

                              Navigator.of(context).pop();
                              setState(() {
                                isLoading=true;
                                saveAssistance();
                              });
                            },
                            pressNo: () {
                              Navigator.of(context).pop();
                            },
                            title: "Appointment",
                            message: "Are you Sure"));
                  },
                  clr: kTextGreenColor,
                  isInfinity: true),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}
