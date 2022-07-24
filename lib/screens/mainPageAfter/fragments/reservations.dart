import 'dart:convert';

import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainpageBefore/webPage.dart';
import 'package:cross_comp/screens/mainpageBefore/whereMap.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReservationFrag extends StatefulWidget {
  ReservationFrag({Key? key}) : super(key: key);

  @override
  _ReservationFragState createState() => _ReservationFragState();
}

class _ReservationFragState extends State<ReservationFrag> {


  String UserId = "";
  bool isLoading=true;
  bool isFacility=false;
  bool isEvent=false;
  bool isFree=false;
  String id='0';
  String name='';
  String street='';
  String city='';
  String day='';
  String date='';
  String timing='';
  String dayDate='';
  String postalCode='';
  String selectedTimings='';
  String type='';

  @override
  void initState() {
    super.initState();
    getWhereIds();
  }
  getWhereIds() async {
    await HelperFunction.getReservationSharedPreference() .then((value) {
      if (value != null)
        setState(() {
          // where = value;
          id=value;
          print("Reservation id  :  $value");
        });
    });



    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null)
        setState(() {

          UserId = value;
          print("UserId  :  $value");

             getReservationData();
        });
    });
  }
  /// This holds the items
  Future<Map<String, dynamic>> getReservationData() async {
    print("saveEventData");

    _timimg.clear();
    String url = mainApiUrl + "?get_reservation=true&id=$id";

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
          try{

            String id= map['server_response']["id"].toString();
            String title= map['server_response']["User_ID"].toString();
            postalCode= map['postalCode'].toString();


            street=map['ef_response']["Street"].toString();
            String free=map['ef_response']["isFree"].toString();
            if(free=="1")
              isFree=true;

            city=map['ef_response']["City_ID"].toString()+", "+map['ef_response']["State_ID"].toString();
            day=map['server_response']["day"].toString();
            date=map['server_response']["date"].toString();
            selectedTimings=map['server_response']["timing"].toString();
            type=map['server_response']["type"].toString();


            if(type=='event')
              name=map['ef_response']["ParkSchoolName"].toString();
            else
              name=map['ef_response']["GymName"].toString();



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



  List<Map<String,String>> _timimg = [];






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading?Center(child: Loading(),) :
      Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Text(
                      street,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: kTextGreenColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      city,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: kTextGreenColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      postalCode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: kTextGreenColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Container(
                      child: isFree?
                          Column(children: [

                            Text(
                              "Cost: FREE!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(25),
                                color: kTextRedColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(15)),
                          ],)
                          :Container(),
                    ),
                    Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(25),
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if(day.toLowerCase().contains("monday"))...[
                      Text(
                        DateTime.now().next(DateTime.monday).toString().substring(8,10)+"-"+DateTime.now().next(DateTime.monday).toString().substring(5,8)+DateTime.now().next(DateTime.monday).toString().substring(0,4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                 if(day.toLowerCase().contains("tuesday"))...[
                      Text(
                        DateTime.now().next(DateTime.tuesday).toString().substring(8,10)+"-"+DateTime.now().next(DateTime.tuesday).toString().substring(5,8)+DateTime.now().next(DateTime.tuesday).toString().substring(0,4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                    if(day.toLowerCase().contains("wednesday"))...[
                      Text(
                         DateTime.now().next(DateTime.wednesday).toString().substring(8,10)+"-"+DateTime.now().next(DateTime.wednesday).toString().substring(5,8)+DateTime.now().next(DateTime.wednesday).toString().substring(0,4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                    if(day.toLowerCase().contains("thursday"))...[
                      Text(
                        DateTime.now().next(DateTime.thursday).toString().substring(8,10)+"-"+DateTime.now().next(DateTime.thursday).toString().substring(5,8)+DateTime.now().next(DateTime.thursday).toString().substring(0,4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                    if(day.toLowerCase().contains("friday"))...[
                      Text(
                        DateTime.now().next(DateTime.friday).toString().substring(8,10)+"-"+DateTime.now().next(DateTime.friday).toString().substring(5,8)+DateTime.now().next(DateTime.friday).toString().substring(0,4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                    if(day.toLowerCase().contains("saturday"))...[
                      Text(
                        DateTime.now().next(DateTime.saturday).toString().substring(8,10)+"-"+DateTime.now().next(DateTime.saturday).toString().substring(5,8)+DateTime.now().next(DateTime.saturday).toString().substring(0,4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                    if(day.toLowerCase().contains("sunday"))...[
                      Text(
                        DateTime.now().next(DateTime.sunday).toString().substring(8,10)+"-"+DateTime.now().next(DateTime.sunday).toString().substring(5,8)+DateTime.now().next(DateTime.sunday).toString().substring(0,4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],

                    Text(
                      selectedTimings,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(25),
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    Container(
                      height: getProportionateScreenHeight(170),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: getProportionateScreenHeight(15)),
                          DefaultButton(
                              text: "Instructions",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebPage(
                                            "http://www.crosscomps.com/instructions")));
                              },
                              clr: kPrimaryColor,
                              isInfinity: true),
                          SizedBox(height: getProportionateScreenHeight(15)),

                          DefaultButton(
                              text: "Change Reservation",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WhereMap()));
                              },
                              clr: kTextGreenColor,
                              isInfinity: true),

                        ],
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

}
extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return this.add(
      Duration(
        days: (day - this.weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}
