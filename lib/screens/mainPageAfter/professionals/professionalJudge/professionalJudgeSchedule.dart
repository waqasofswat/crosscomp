import 'dart:convert';

import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/chatScreen.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/professionalJudge/professionalJudgeNavigation.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/professionalJudge/professionalJudgeParticipants.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProfessionalJudgeSchedule extends StatefulWidget {
  ProfessionalJudgeSchedule({Key? key}) : super(key: key);

  @override
  _ProfessionalJudgeScheduleState createState() =>
      _ProfessionalJudgeScheduleState();
}

class _ProfessionalJudgeScheduleState extends State<ProfessionalJudgeSchedule> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  String userId = '';
  bool isLoading = true;

  double startLatitude=0;
  double startLongitude=0;
  @override
  void initState() {
    super.initState();
    getUserId();
    // handleAppLifecycleState();
  }

  getUserId() async {
    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          userId = value;

          _getUserLocation();
        });
      }
    });
  }

  void _getUserLocation() async {
    print('_getUserLocation');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print('_getUserLocation 2 ');
    try {
      print('_getUserLocation : try');
      List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      print('_getUserLocation : await');
      setState(() {
        print(
            '_getUserLocation : setstate ${position.latitude} ${position.longitude}');

        startLatitude=position.latitude;
        startLongitude= position.longitude;
        print('${placemark[0].name}');
        getJudgeScheduleData();

      });
    } catch (e) {
      print('_getUserLocation : error : $e');
      print(e);
    }
  }

  Future<Map<String, dynamic>> getJudgeScheduleData() async {
    print("getAllEventData");

    _timimg.clear();
    String url = mainApiUrl + "?my_judging_schedule=true&userId=$userId";

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
            List<String> monthArr = [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "June",
              "July",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec"
            ];
            int size = map['size'];

            DateTime dateX = DateTime.now();
            for (int i = 0; i < size; i++) {
              String currDate = dateX.day.toString() +
                  "/" +
                  (dateX.month + 1).toString() +
                  "/" +
                  dateX.year.toString();
              String day = map['server_response'][i]['day'].toString();
              // for (int i = 0; i < 7; i++) {
              //   DateTime dateZ = dateX.add(Duration(days: i));
              //
              //   String currDay = DateFormat('EEEE').format(dateZ);
              //   print("Current Day : " + currDay);
              //   print(" Day : " + day);
              //   if (currDay == day) {
              //     currDate = dateZ.month.toString() +
              //         "/" +
              //         dateZ.day.toString() +
              //         "/" +
              //         dateZ.year.toString();
              //     print("$day  -------  $currDay");
              //   }
              //   print("-------------------");
              // }
              String id = map['server_response'][i]["id"].toString();
              String timing = map['server_response'][i]["timing"].toString();
              String date = map['server_response'][i]["date"].toString();
              String type = map['ef_response'][i]["Type"].toString();
              String manager = map['ef_response'][i]["Manager"].toString();
              String city = map['ef_response'][i]["City_ID"].toString();
              String street = map['ef_response'][i]["Street"].toString();
              String title = '';
              String efId = '';
              if (type == 'event'){

                efId= map['ef_response'][i]["Event_ID"].toString();
                title= map['ef_response'][i]["ParkSchoolName"].toString();
              }
              else{

                title = map['ef_response'][i]["GymName"].toString();
                efId = map['ef_response'][i]["Facility_ID"].toString();
              }


              double destinationLatitude = double.parse(map['ef_response'][i]["lat"].toString());
              double destinationLongitude = double.parse(map['ef_response'][i]["lon"].toString());

              double distanceInMeters = await Geolocator.bearingBetween(
                startLatitude,
                startLongitude,
                destinationLatitude,
                destinationLongitude,
              );

              bool statuuuus=false;
              if(distanceInMeters> -50  && distanceInMeters < 50)
                statuuuus=true;

              print("distanceInMeters : $distanceInMeters");
              print("distanceInMeters : status : $statuuuus");


              DateTime date2 = DateTime.parse(date);


              final difference = daysBetween(dateX, date2);
              print("difference");
              print(difference);


              if(difference>=0){
                Map<String, dynamic> mapList = {
                  "address": street,
                  "city": city,
                  "manager": manager,
                  "name": title,
                  "hours": timing,
                  "day": day,
                  "date": date,
                  "id": id,
                  "ef_id": efId,
                  "type": type,
                  "status": statuuuus

                };
                setState(() {
                  _timimg.add(mapList);
                });
              }

            }
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
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  Future<Map<String, dynamic>> deleteJudgeSchedule(String id) async {
    print("delete_judges");

    _timimg.clear();
    String url = mainApiUrl + "?deletejudges=true&id=$id";

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
          getJudgeScheduleData();
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

  /// This holds the items

  List<Map<String, dynamic>> _timimg = [];

  /// This holds the item count
  int counter = 0;

  Widget animatedTile(BuildContext context, int index, animation) {
    Map<String, dynamic> timimg = _timimg[index];

    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return curverMethod(animation, timimg, textStyle, index);
  }

  SlideTransition curverMethod(
      animation, Map<String, dynamic> item, TextStyle textStyle, int pos) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: GestureDetector(
        onTap: () {},
        child: Container(
            width: double.infinity,
            child: Column(
              children: [
                newMethodEvent(item),
              ],
            )),
      ),
    );
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
          "My Judging Schedule",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: Loading(),
            )
          : Center(
              child: Column(
                children: [
                  Expanded(
                    child: AnimatedList(
                      key: listKey,
                      initialItemCount: _timimg.length,
                      itemBuilder: (context, index, animation) {
                        return animatedTile(
                            context, index, animation); // Refer step 3
                      },
                    ),
                    flex: 10,
                  ),
                ],
              ),
            ),
    );
  }

  Container newMethodEvent(Map<String, dynamic> item) {
    bool isStatus = item["status"];
    return Container(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          GestureDetector(
            onTap: () {
              if (isStatus) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfessionalJudgeParticipants(mapList: item)));
              }
            },
            child: Column(
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: item["day"].toString(),
                      style: TextStyle(
                        color: isStatus ? kRedColor : Colors.black87,
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.w900,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' , ',
                            style: TextStyle(
                              color: isStatus ? kRedColor : Colors.black87,
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w900,
                            )),
                        TextSpan(
                            text: item["date"].toString(),
                            style: TextStyle(
                              color: isStatus ? kRedColor : Colors.black87,
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w900,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(2)),
                Text(
                  item["hours"].toString(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: isStatus ? kRedColor : Colors.black87,
                    fontSize: getProportionateScreenHeight(18),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfessionalJudgeNavigation()));
            },
            child: Column(
              children: [
                Text(
                  item["name"].toString(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kTextGreenColor,
                    fontSize: getProportionateScreenHeight(18),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(2)),
                Text(
                  item["address"].toString(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kTextGreenColor,
                    fontSize: getProportionateScreenHeight(15),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  item["city"].toString(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kTextGreenColor,
                    fontSize: getProportionateScreenHeight(15),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(2)),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage()));
            },
            child: Text(
              item["manager"].toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: getProportionateScreenHeight(18),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => ConformDialog(
                    pressYes: () {

                      setState(() {
                        isLoading=true;
                        deleteJudgeSchedule( item["id"].toString());
                        Navigator.of(context).pop();
                      });

                    },
                    pressNo: () {
                      Navigator.of(context).pop();
                    },
                    title: "Remove Manager",
                    message:
                        "Do you want to remove ${item["manager"].toString()}"),
              );
            },
            child: Image.asset(
              "assets/images/red_cross.png",
              height: getProportionateScreenHeight(15),
              width: getProportionateScreenWidth(15),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Text(
            "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black87,
              fontSize: getProportionateScreenHeight(18),
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
        ],
      ),
    );
  }
}

class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  @override
  OutlinedBorder resolve(Set<MaterialState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    );
  }
}
