import 'dart:convert';

import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/trainingSession.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../chatScreen.dart';

class Trainee extends StatefulWidget {
  Map<String,dynamic> mapList;
  Trainee({Key? key,required this.mapList}) : super(key: key);

  @override
  _TraineeState createState() => _TraineeState();
}

class _TraineeState extends State<Trainee> with WidgetsBindingObserver {
  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();



  bool isLoading = true;
  bool isPart = false;
  String manager='';
  String efName='';
  @override
  void initState() {
    super.initState();

    getParticipants();
  }

  Future<Map<String, dynamic>> getParticipants() async {
    print("getParticipants");

    _part.clear();
    String url = mainApiUrl + "?get_reservation_participants=true&ef_id=${widget.mapList["ef_id"]}&day=${widget.mapList["day"]}&date=${widget.mapList["date"]}&timing=${widget.mapList["hours"]}&type=${widget.mapList["type"]}";

    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      if (response.body.toString().contains("Failure")) {
        print("response Failed");
        setState(() {
          // _loading = false;
          isLoading = false;
          isPart = true;

          // progress?.dismiss();
        });
      } else {
        // import 'dart:convert';

        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status'] == "failed") {
          setState(() {
            isLoading = false;
            isPart = true;
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
            if (size < 1) {
              setState(() {
                isPart = true;
              });
            }
            DateTime dateX = DateTime.now();
            for (int i = 0; i < size; i++) {
              String currDate = dateX.day.toString() +
                  "/" +
                  (dateX.month + 1).toString() +
                  "/" +
                  dateX.year.toString();
              //  day = map['server_response'][i]["reservation"]['day'].toString();
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

              Map<String, dynamic> mapX = {
                "name": "",
                "age": "",
                "date": "",
                "status": "Current",
                "statustype": "1",
                "total_scores": "0.0",
                "shuttle": "0.0",
                "squats": "0.0",
                "legRise": "0.0",
                "pushups": "0.0",
                "shuttle_Grade": "D",
                "squats_Grade": "D",
                "legRise_Grade": "D",
                "pushup_Grade": "D",
              };


              String id = map['server_response'][i]["reservation"]["id"].toString();
              bool isFree=false;
              bool checkIn=false;
              String free = map['server_response'][i]["reservation"]["isFree"].toString();
              String checkedIn = map['server_response'][i]["reservation"]["checkIn"].toString();

              if(free=="1")
                isFree=true;
              if(checkedIn=="1")
                checkIn=true;


              String timing = map['server_response'][i]["reservation"]["timing"].toString();
              //   date = map['server_response'][i]["reservation"]["date"].toString();

              String uid = map['server_response'][i]["user"]["User_ID"].toString();
              String userName = map['server_response'][i]["user"]["First_Name"].toString()+" "+map['server_response'][i]["user"]["Last_Name"].toString();

              String type = map['ef_response']["Type"].toString();
              manager = map['ef_response']["Manager"].toString();
              String city = map['ef_response']["City_ID"].toString();
              String street = map['ef_response']["Street"].toString();
              String title = '';
              String efId = '';
              if (type == 'event') {
                title = map['ef_response']["ParkSchoolName"].toString();
                efId = map['ef_response']["Event_ID"].toString();
              } else{
                title = map['ef_response']["GymName"].toString();
                efId = map['ef_response']["Facility_ID"].toString();
              }

              efName=title;


              int exeSize = map['server_response'][i]["scoreSize"];
              if(exeSize>0){
                String metersX = map['server_response'][i]["score"]["Meters"].toString();
                String metersGradeX = map['server_response'][i]["score"]["Meters_Grade"].toString();
                String squatsX = map['server_response'][i]["score"]["Squats"].toString();
                String squatsGradeX = map['server_response'][i]["score"]["Squats_Grade"].toString();
                String legRaisesX = map['server_response'][i]["score"]["Leg_raises"].toString();
                String legRaisesGradeX = map['server_response'][i]["score"]["Leg_raises_Grade"].toString();
                String pushupsX = map['server_response'][i]["score"]["Pushups"].toString();
                String pushupsGradeX = map['server_response'][i]["score"]["Pushup_Grade"].toString();


                var moonLanding = DateTime.parse(map['server_response'][i]["score"]["Date"]);
                print(DateFormat.yMMMd().format(DateTime.now()));

                var diff=DateTime.now().difference(moonLanding);
                int diffDays=diff.inDays;

                String statustype="1";
                String status="Current";
                double ttlScore=double.parse(map['server_response'][i]["score"]["Total_Score"]);

                String date = DateFormat.yMMMd().format(moonLanding);
                if(ttlScore<20){
                  if(diffDays<=21){

                    statustype="1";
                    status="Current";
                  }else if(diffDays<=28){

                    statustype="2";
                    status="Expiring";
                  }else {

                    statustype="3";
                    status="Expired";
                  }
                }
                else if(ttlScore>=20 && ttlScore<40){
                  if(diffDays<=42){

                    statustype="1";
                    status="Current";
                  }
                  else if(diffDays<=56){

                    statustype="2";
                    status="Expiring";
                  }
                  else {

                    statustype="3";
                    status="Expired";
                  }
                }
                else if(ttlScore>=40 && ttlScore<60){
                  if(diffDays<=63){

                    statustype="1";
                    status="Current";
                  }else if(diffDays<=84){

                    statustype="2";
                    status="Expiring";
                  }else {

                    statustype="3";
                    status="Expired";
                  }
                }
                else if(ttlScore>=60 && ttlScore<80){
                  if(diffDays<=91){

                    statustype="1";
                    status="Current";
                  }else if(diffDays<=112){

                    statustype="2";
                    status="Expiring";
                  }else {

                    statustype="3";
                    status="Expired";
                  }
                }
                else if(ttlScore>=80 && ttlScore<100){
                  if(diffDays<=112){

                    statustype="1";
                    status="Current";
                  }else if(diffDays<=140){

                    statustype="2";
                    status="Expiring";
                  }else {

                    statustype="3";
                    status="Expired";
                  }
                }
                else{
                  if(diffDays<=140){

                    statustype="1";
                    status="Current";
                  }else if(diffDays<=168){

                    statustype="2";
                    status="Expiring";
                  }else {

                    statustype="3";
                    status="Expired";
                  }
                }


                mapX = {
                  "name": userName,
                  "age": map["server_response"][i]["score"]["Age"],
                  "date":date,
                  "status": status,
                  "statustype": statustype,
                  "total_scores": ttlScore.toString(),
                  "shuttle": metersX,
                  "squats": squatsX,
                  "legRise": legRaisesX,
                  "pushups": pushupsX,
                  "shuttle_Grade": metersGradeX,
                  "squats_Grade": squatsGradeX,
                  "legRise_Grade": legRaisesGradeX,
                  "pushups_Grade": pushupsGradeX,
                };


              }


              Map<String, dynamic> mapList = {
                "id": id,
                "uid": uid,
                "names": userName,
                "title": title,
                "status": isFree,
                "isGreen": checkIn,
                "ef_id": efId,
                "type": type,
                "date": widget.mapList["date"],
                "map":mapX
              };
              setState(() {
                _part.add(mapList);
              });

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
  Future<Map<String, dynamic>> deleteParticipant(String id) async {
    print("deleteParticipant");

    _part.clear();
    String url = mainApiUrl + "?delete_participant=true&id=$id";

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
          getParticipants();
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


  List<Map<String, dynamic>> _part = [];


  Widget animatedTileO(BuildContext context, int index, animation,
      List<Map<String, dynamic>> item) {
    Map<String, dynamic> part = item[index];

    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(16),
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    );
    return participantsRow(animation, part, textStyle);
  }

  SlideTransition participantsRow(
      animation, Map<String, dynamic> item, TextStyle textStyle) {
    bool isStatus = item["status"];
    bool isGreen = item["isGreen"];
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: Container(
        height: 35.0,
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 1,
                child: Container(
                    child: isStatus
                        ? Text(
                            "*",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
                              color: kRedColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container()),
              ),
              Expanded(
                flex: 18,
                child: GestureDetector(
                  onTap: () {
                    if (isGreen) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainingSession(mapList: item,mapListOld: widget.mapList)));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatPage()));
                    }
                  },
                  child: Text(
                    item["names"].toString(),
                    textAlign: TextAlign.start,
                    style: isGreen
                        ? TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: kTextGreenColor,
                            fontWeight: FontWeight.bold,
                          )
                        : textStyle,
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => ConformDialog(
                          pressYes: () {},
                          pressNo: () {
                            Navigator.of(context).pop();
                          },
                          title: "Remove User",
                          message: "Do you want to remove this person"),
                    );
                  },
                  child: Image.asset(
                    "assets/images/red_cross.png",
                    height: getProportionateScreenHeight(15),
                    width: getProportionateScreenWidth(15),
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
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
          "Trainee",
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
        child:
        Container(
          child:
          isPart
              ? Column(
            children: [
              Text(
                "No Participants",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: kRedColor,
                  fontSize: getProportionateScreenHeight(22),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          )
              :
          Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(25)),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             ProfessionalJudgeParticipants()));
                },
                child: Column(
                  children: [
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: widget.mapList["day"],
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w900,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' , ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: getProportionateScreenHeight(18),
                                  fontWeight: FontWeight.w900,
                                )),
                            TextSpan(
                                text: widget.mapList["date"],
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: getProportionateScreenHeight(18),
                                  fontWeight: FontWeight.w900,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => FacilityParticipantSchedule()));
                },
                child: Column(
                  children: [
                    Text(
                      efName,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatPage()));
                },
                child: Text(
                  manager                                                           ,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(18),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              Container(
                height: _part.length * 50.0,
                child: AnimatedList(
                  key: listKeyK,
                  initialItemCount: _part.length,
                  itemBuilder: (context, index, animation) {
                    return animatedTileO(
                        context, index, animation, _part); // Refer step 3
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
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
