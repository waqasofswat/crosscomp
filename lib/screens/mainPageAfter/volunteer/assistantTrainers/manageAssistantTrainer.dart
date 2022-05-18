import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/selectFreeTrainingEvent.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/selectFreeTrainingFacility.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../chatScreen.dart';
import 'package:http/http.dart' as http;

class ManageAssistantTrainer extends StatefulWidget {
  ManageAssistantTrainer({Key? key}) : super(key: key);

  @override
  _ManageAssistantTrainerState createState() => _ManageAssistantTrainerState();
}

class _ManageAssistantTrainerState extends State<ManageAssistantTrainer> {
  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();

  bool  isLoading = true;
  @override
  void initState() {
    super.initState();

    getParticipants();
  }

  Future<Map<String, dynamic>> getParticipants() async {
    print("getParticipants");
    List<String> userIdx=[];

    _part.clear();
    String url = mainApiUrl + "?all_judges=true";

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


           int size=map['size'];
           for(int i=0; i<size; i++){
             bool isAvi=false;
             String uid=map['judge'][i]["User_ID"];
             String id=map['server_response'][i]["id"];


             for(int x=0;x<userIdx.length; x++){
               if(userIdx[x]==uid)
                 isAvi=true;
             }
             userIdx.add(uid);
             if(!isAvi){

               String name="${map['judge'][i]["First_Name"]} ${map['judge'][i]["Last_Name"]}";
               _part.add({"id": id,"uid": uid,"names": name, "status": false, "isGreen": false});
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
  Future<Map<String, dynamic>> deleteAssistanceJudges(String id) async {
    print("deleteAssistanceJudges: $id");

    _part.clear();
    String url = mainApiUrl + "?deleteAssistanceJudges=true&id=$id";

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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => TrainingSession()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatPage()));
                    }
                  },
                  child: Text(
                    StringUtils.capitalize(item["names"].toString()),
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
                child: Visibility(
                  visible: true,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => ConformDialog(
                            pressYes: () {
                              setState(() {

                                isLoading=true;
                                deleteAssistanceJudges( item["id"].toString());

                                Navigator.of(context).pop();
                              });
                            },
                            pressNo: () {
                              Navigator.of(context).pop();
                            },
                            title: "Remove Assistant",
                            message:
                                "Do you want to remove this Assistant Trainer"),
                      );
                    },
                    child: Image.asset(
                      "assets/images/red_cross.png",
                      height: getProportionateScreenHeight(15),
                      width: getProportionateScreenWidth(15),
                    ),
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
          "Manage Assistant Trainer",
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
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: getProportionateScreenHeight(180),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20),vertical: getProportionateScreenHeight(10)),
                    child: DefaultButton(
                        text: "Select a Free Training Event",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectFreeTrainingEvent()));
                        },
                        clr: kTextGreenColor,
                        isInfinity: true),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20),vertical: getProportionateScreenHeight(10)),
                    child: DefaultButton(
                        text: "Select a Free Training Facility",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SelectFreeTrainingFacility()));
                        },
                        clr: kTextGreenColor,
                        isInfinity: true),
                  ),
                ],),),),
          ],
        ),
      ),
    );
  }
}
