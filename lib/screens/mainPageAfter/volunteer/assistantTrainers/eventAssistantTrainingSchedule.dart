import 'dart:convert';

import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'eventRecruitAssistant.dart';
import 'package:http/http.dart' as http;

class AssistantTrainerScheduleEvent extends StatefulWidget {
  String eid;
  AssistantTrainerScheduleEvent({Key? key,required this.eid}) : super(key: key);

  @override
  _AssistantTrainerScheduleEventState createState() =>
      _AssistantTrainerScheduleEventState();
}

class _AssistantTrainerScheduleEventState
    extends State<AssistantTrainerScheduleEvent> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  /// This holds the items
  bool isLoading=true;
  String title='';
  String dayDate='';
  @override
  void initState() {

    super.initState();
    getEventJudgesData();
    // handleAppLifecycleState();
  }



  Future<Map<String, dynamic>> getEventJudgesData() async {
    print("getEventParticipantsData");

    _timimg.clear();
    _part.clear();
    String url = mainApiUrl + "?get_event_facility_judge=true&id=${widget.eid}&type=event";

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

            title=map['ef_response']['ParkSchoolName'].toString();
            var moonLanding = DateTime.parse(map["ef_response"]["Date"]);
            // List<String> monthArr=["January","February","March","April","May","June","July","August","September","October","November","December"];
            List<String> monthArr=["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"];

            dayDate=map['ef_response']['Day'].toString()+", "+moonLanding.day.toString()+" "+monthArr[moonLanding.month]+", "+moonLanding.year.toString();

            try{
              int size= map['size'];
              for(int i=0; i<size; i++){

                int sizeT=_timimg.length;
                String tmng=map['server_response'][i]['judges_appointments']['timing'].toString();
                String participant=map['server_response'][i]['participants'].toString();
                //  String isFree=map['server_response'][i]['judges_appointments']['isFree'].toString();

                // String checkedIn=map['server_response'][i]['judges_appointments']['checkIn'].toString();

                String name=map['server_response'][i]['judge']['First_Name'].toString()+" "+map['server_response'][i]['judge']['Last_Name'].toString();
                int indeX=-1;
                String rid=map['server_response'][i]['judges_appointments']['id'].toString();
                String uid=map['server_response'][i]['judge']['User_ID'].toString();
                for(int x=0; x<sizeT; x++){
                  if(_timimg[x]["date"].toString()==tmng)
                    indeX=x;
                }

                String day=map['ef_response']['Day'].toString();
                String date=map['ef_response']['Date'].toString();
                String ef_id=map['ef_response']['Event_ID'].toString();
                if(indeX!=-1){
                  _part[indeX].add({"names": name,"id": rid,"uid": uid, "status": false});
                }else{
                  _timimg.add({
                    "date":tmng,
                    "trainee":participant,
                    "day":day,
                    "tmng":date,
                    "ef_id":ef_id
                  });
                  _part.add([{"names": name,"id": rid, "uid": uid, "status": false,"day":day,"date":date,"tmng":tmng}]);
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

  /// This holds the items

  List<Map<String, dynamic>> _timimg = [];
  List<List<Map<String, dynamic>>> _part = [];

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
    return assistantRow(animation, part, textStyle);
  }

  SlideTransition assistantRow(
      animation, Map<String, dynamic> item, TextStyle textStyle) {
    // bool isStatus = item["status"];
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
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //       child: isStatus
            //           ? Text(
            //               "*",
            //               textAlign: TextAlign.start,
            //               style: TextStyle(color: kRedColor),
            //             )
            //           : Container()),
            // ),
            Expanded(
              flex: 14,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => EventCheckIn()));
                },
                child: Text(
                  item["names"].toString(),
                  textAlign: TextAlign.start,
                  style: textStyle,
                ),
              ),
            ),
            // Expanded(
            //   flex: 4,
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       shape: SelectedBorder(),
            //       backgroundColor: MaterialStateProperty.all(kTextGreenColor),
            //     ),
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => ChatPage()));
            //     },
            //     child: Text(
            //       "text",
            //       style: TextStyle(
            //         fontSize: getProportionateScreenWidth(15),
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
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
          "Assistant Trainer Schedule",
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
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      dayDate,
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

  Container newMethodEvent(Map<String, dynamic> item,) {
    String timingText=item["date"].toString();
    String participantText= item["trainee"].toString();
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Divider(color: Colors.black),
          Container(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      timingText,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Trainees: ',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w900,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: participantText,
                                style: TextStyle(
                                    color: kRedColor,
                                    fontWeight: FontWeight.bold)),
                            // TextSpan(text: ' world!'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: SelectedBorder(),
                          backgroundColor:
                              MaterialStateProperty.all(kTextGreenColor),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EventRecruitAssistant(mapList: item,title: title,)));
                        },
                        child: Text(
                          "Recruit",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
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
