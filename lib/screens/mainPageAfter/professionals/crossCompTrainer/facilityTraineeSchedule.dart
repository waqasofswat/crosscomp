import 'dart:convert';

import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/facilities/facilityConformDialog.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../chatScreen.dart';
import 'facilityTraineeCheckIn.dart';
import 'package:http/http.dart' as http;

class FacilityTraineeSchedule extends StatefulWidget {
  final String facilityId;
  FacilityTraineeSchedule({Key? key,required this.facilityId}) : super(key: key);

  @override
  _FacilityTraineeScheduleState createState() =>
      _FacilityTraineeScheduleState();
}

class _FacilityTraineeScheduleState extends State<FacilityTraineeSchedule> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  /// This holds the items

  bool isLoading=true;
  String title='';
  String dayDate='';
  /// This holds the items
  @override
  void initState() {

    super.initState();
    getFacilityParticipantsData();
    // handleAppLifecycleState();
  }
  Future<Map<String, dynamic>> deleteParticipantData(String id) async {
    print("deleteParticipantData");


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

          getFacilityParticipantsData();
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

  Future<Map<String, dynamic>> getFacilityParticipantsData() async {
    print("getEventParticipantsData");

    _timimg.clear();
    _part.clear();
    String url = mainApiUrl + "?get_event_facility_participants=true&id=${widget.facilityId}&type=facility";

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

            title=map['ef_response']['GymName'].toString();
            var moonLanding = DateTime.parse(map["ef_response"]["Date"]);
            // List<String> monthArr=["January","February","March","April","May","June","July","August","September","October","November","December"];
            List<String> monthArr=["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"];

            // dayDate=map['ef_response']['Day'].toString()+", "+moonLanding.day.toString()+" "+monthArr[moonLanding.month]+", "+moonLanding.year.toString();

            try{

              DateTime dateX = DateTime.now();
              int size= map['size'];
              for(int i=0; i<size; i++){
                String currDate=dateX.day.toString()+"/"+(dateX.month+1).toString()+"/"+dateX.year.toString();
                String day=map['server_response'][i]['reservation']['day'].toString();
                for(int i=0; i<7; i++){

                  DateTime dateZ= dateX.add(Duration(days: i));

                  String currDay=DateFormat('EEEE').format(dateZ);
                  print("Current Day : "+currDay);
                  print(" Day : "+day);
                  if(currDay==day){

                    currDate=dateZ.month.toString()+"/"+dateZ.day.toString()+"/"+dateZ.year.toString();
                    print("$day  -------  $currDay");
                  }
                  print("-------------------");
                }
                int sizeT=_timimg.length;


                String xTiming=map['server_response'][i]['reservation']['timing'].toString();
                String tmng=day+", "+currDate+", "+xTiming;

                String isFree=map['server_response'][i]['reservation']['isFree'].toString();
                bool status=false;
                if(isFree!="0")
                  status=true;
                String checkedIn=map['server_response'][i]['reservation']['checkIn'].toString();
                String name=map['server_response'][i]['user']['First_Name'].toString()+" "+map['server_response'][i]['user']['Last_Name'].toString();
                int indeX=-1;

                String uid=map['server_response'][i]['user']['User_ID'].toString();
                String rid=map['server_response'][i]['reservation']['id'].toString();
                for(int x=0; x<sizeT; x++){
                  if(_timimg[x]["timing"].toString()==tmng && _timimg[x]["day"].toString()==day)
                    indeX=x;
                }
                if(indeX!=-1){
                  _part[indeX].add({"names": name,"checkIn": checkedIn,"id": rid,"uid": uid, "status": status});
                }else{
                  _timimg.add({
                    "timing":tmng,
                    "day":day,
                    "tmng":xTiming,
                    "date":currDate,
                  });
                  _part.add([{"names": name,"checkIn": checkedIn, "id": rid, "uid": uid,"status": status}]);
                }
              }
            }catch(e){
              print(e.toString());
            }
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

  List<Map<String, dynamic>> _timimg = [
  ];
  List<List<Map<String, dynamic>>> _part = [

  ];

  /// This holds the item count
  int counter = 0;

  Widget animatedTile(BuildContext context, int index, animation) {
    Map<String, dynamic> timimg = _timimg[index];

    final GlobalKey<AnimatedListState> listKeyK =
    GlobalKey<AnimatedListState>();
    List<Map<String, dynamic>> part = _part[index];
    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return curverMethod(animation, timimg, textStyle, part, index, listKeyK);
  }

  SlideTransition curverMethod(
      animation,
      Map<String, dynamic> item,
      TextStyle textStyle,
      List<Map<String, dynamic>> part,
      int pos,
      GlobalKey<AnimatedListState> listKeyK) {
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
                Container(
                  height: part.length * 50.0,
                  child: AnimatedList(
                    key: listKeyK,
                    initialItemCount: part.length,
                    itemBuilder: (context, index, animation) {
                      return animatedTileO(
                          context, index, animation, part); // Refer step 3
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget animatedTileO(BuildContext context, int index, animation,
      List<Map<String, dynamic>> item) {
    Map<String, dynamic> part = item[index];

    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return participantsRow(animation, part);
  }

  SlideTransition participantsRow(
      animation, Map<String, dynamic> item) {
    bool isStatus = item["status"];
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
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
                    style: TextStyle(color: kRedColor),
                  )
                      : Container()),
            ),
            Expanded(
              flex: 14,
              child: GestureDetector(
                onTap: () {
                  if(item["checkIn"].toString()=="0"){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FacilityTraineeCheckIn(userId: item["uid"].toString(),rId:  item["id"].toString(),facilityId: widget.facilityId,)));
                  }
                },
                child: Text(
                  item["names"].toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: item["checkIn"].toString()=="0"?kPrimaryColor:kGreenColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: SelectedBorder(),
                  backgroundColor: MaterialStateProperty.all(kTextGreenColor),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatPage()));
                },
                child: Text(
                  "text",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.white,
                  ),
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
                    builder: (_) => FacilityConformDialog(
                        pressYes: () {
                          setState(() {

                            isLoading=true;
                            deleteParticipantData( item["id"].toString());

                            Navigator.of(context).pop();
                          });
                        },
                        pressNo: () {
                          Navigator.of(context).pop();
                        },
                        title: "Remove Participant",
                        message: "Do you want to remove this Participant"),
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
          "Trainee Schedule",
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
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(25)),
                    Text(
                      "BreckenFit Gym",
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
              ),
            ),
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
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Divider(color: Colors.black),
          SizedBox(height: getProportionateScreenHeight(5)),
          Container(
            child: Text(
              item["timing"].toString(),
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black87,
                fontSize: getProportionateScreenHeight(18),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Divider(color: Colors.black),
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
