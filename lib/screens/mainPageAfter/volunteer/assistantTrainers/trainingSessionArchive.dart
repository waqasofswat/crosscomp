import 'dart:convert';

import 'package:cross_comp/component/default_button_rect.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TrainingSessionArchive extends StatefulWidget {

  Map<String, dynamic> mapList;
  TrainingSessionArchive({Key? key,required this.mapList}) : super(key: key);

  @override
  _TrainingSessionArchiveState createState() => _TrainingSessionArchiveState();
}

class _TrainingSessionArchiveState extends State<TrainingSessionArchive> {
  PageController controller = PageController(initialPage: 0);


  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    getScoresMethod();
  }
  Future<Map<String, dynamic>> getScoresMethod() async {

    print("getScoresMethod");
    print("UserId=${widget.mapList["uid"]}");
    int uid = int.parse(widget.mapList["uid"]);
    scoresMap.clear();
    exerciseMap.clear();
    String url = mainApiUrl + "?getUserArchiveScores=true&userId=$uid";

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
            // _btnController.error();
            // progress?.dismiss();
            isLoading = false;
          });
        } else {
          int size = map["size"];
          print(size);



          for (var i = 0; i < size; i++) {
            List<Map<String, String>> exeList=[];


            var moonLanding = DateTime.parse(map["server_response"][i]["main"]["date"]);
            print(DateFormat.yMMMd().format(DateTime.now()));

            var diff=DateTime.now().difference(moonLanding);
            int diffDays=diff.inDays;


           String efName="";
            String efType=map["server_response"][i]["ef"]["Type"];
            if(efType=="event"){
              efName=map["server_response"][i]["ef"]["ParkSchoolName"];
            }else{
              efName=map["server_response"][i]["ef"]["GymName"];
            }

            String  managerName="${map["server_response"][i]["judge"]["First_Name"]} ${map["server_response"][i]["judge"]["Last_Name"]}";
            Map<String, dynamic> sMap= {
              "name_of_training": efName,
              "date": map["server_response"][i]["main"]["date"],
              "time_elapsed": map["server_response"][i]["main"]["total_time"],
              "assistant_trainer": managerName,
            };

            int exeSize = map["server_response"][i]["exeSize"];
            for(int x=0; x<exeSize; x++){

              exeList.add({"name": map["server_response"][i]["exe"][x]["name"], "reps": map["server_response"][i]["exe"][x]["reps"], "min": map["server_response"][i]["exe"][x]["time"]});

            }
            scoresMap.add(sMap);
            exerciseMap.add(exeList);

          }
          setState(() {
            isLoading = false;
          });
        }

        print("response Success");

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => MainPage(
        //             notificationsActionStreamSubscription:
        //                 widget.notificationsActionStreamSubscription)));

      }
      // return null;
      return json.decode(response.body.toString());
    } else {
      // _btnController.error();
      // progress?.dismiss();
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to fetch data');
    }
  }

  List<List<Map<String, String>>> exerciseMap = [];
  List<Map<String, dynamic>> scoresMap = [];

  var currentPageValue = 0.0;
  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;
      });
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Training Session",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading?Center(child: Loading() ,) :
      Container(
          child: Stack(
        children: [
          upDownPageView(),
        ],
      )),
    );
  }

  PageView upDownPageView() {
    return PageView.builder(
      controller: controller,
      itemBuilder: (context, position) {
        if (position == currentPageValue.floor()) {
          return Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: scorePageMethod(scoresMap[position], position),
          );
        } else if (position == currentPageValue.floor() + 1) {
          return Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: scorePageMethod(scoresMap[position], position),
          );
        } else {
          return scorePageMethod(scoresMap[position], position);
        }
      },
      itemCount: scoresMap.length,
    );
  }

  Container scorePageMethod(Map<String, dynamic> map, int index) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        widget.mapList["names"],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(25),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.mapList["map"]["age"],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  map["name_of_training"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          if (currentPageValue > 0) {
                            setState(() {
                              print(controller.page.toString());
                              int pg = controller.page!.toInt() - 1;

                              print(pg);
                              controller.animateToPage(
                                pg,
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 400),
                              );
                            });
                          }
                        },
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: kTextGreenColor,
                          size: 40.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        map["date"].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          if (currentPageValue < 10) {
                            setState(() {
                              print(controller.page.toString());
                              int pg = controller.page!.toInt() + 1;

                              print(pg);
                              controller.animateToPage(
                                pg,
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 400),
                              );
                            });
                          }
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: kTextGreenColor,
                          size: 40.0,
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  map["time_elapsed"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  map["assistant_trainer"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Table(
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    TableRow(children: [
                      Container(
                          color: Colors.grey[400],
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Exercise",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                          color: Colors.grey[400],
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Reps",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                          color: Colors.grey[400],
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Min",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ]),
                    for (var exe in exerciseMap[index])
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            exe["name"].toString(),
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            exe["reps"].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            exe["min"].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DefaultButtonRect(
                text: "Exit",
                press: () {
                  Navigator.of(context).pop();
                },
                clr: kRedColor,
                isInfinity: true),
          )
        ],
      ),
    );
  }

  PageView otherPageView() {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: controller,
      itemBuilder: (context, position) {
        if (position == currentPageValue.floor()) {
          return Transform(
            transform: Matrix4.identity()
              ..rotateY(currentPageValue - position)
              ..rotateZ(currentPageValue - position),
            child: Container(
              color: position % 2 == 0 ? Colors.blue : Colors.pink,
              child: Center(
                child: Text(
                  "Page",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          );
        } else if (position == currentPageValue.floor() + 1) {
          return Transform(
            transform: Matrix4.identity()
              ..rotateY(currentPageValue - position)
              ..rotateZ(currentPageValue - position),
            child: Container(
              color: position % 2 == 0 ? Colors.blue : Colors.pink,
              child: Center(
                child: Text(
                  "Page",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: position % 2 == 0 ? Colors.blue : Colors.pink,
            child: Center(
              child: Text(
                "Page",
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
            ),
          );
        }
      },
      itemCount: 10,
    );
  }

  PageView transPageView() {
    return PageView.builder(
      controller: controller,
      itemBuilder: (context, position) {
        if (position == currentPageValue.floor()) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(currentPageValue - position)
              ..rotateY(currentPageValue - position)
              ..rotateZ(currentPageValue - position),
            child: Container(
              color: position % 2 == 0 ? Colors.blue : Colors.pink,
              child: Center(
                child: Text(
                  "Page",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          );
        } else if (position == currentPageValue.floor() + 1) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(currentPageValue - position)
              ..rotateY(currentPageValue - position)
              ..rotateZ(currentPageValue - position),
            child: Container(
              color: position % 2 == 0 ? Colors.blue : Colors.pink,
              child: Center(
                child: Text(
                  "Page",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: position % 2 == 0 ? Colors.blue : Colors.pink,
            child: Center(
              child: Text(
                "Page",
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
            ),
          );
        }
      },
      itemCount: 10,
    );
  }
}
