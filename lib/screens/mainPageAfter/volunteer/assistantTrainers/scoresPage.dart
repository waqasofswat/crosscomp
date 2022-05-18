import 'dart:convert';

import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class ScoresPage extends StatefulWidget {

  Map<String, dynamic> mapList;
   ScoresPage({Key? key,required this.mapList}) : super(key: key);

  @override
  _ScoresPageState createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> {

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

    String url = mainApiUrl + "?getUser_Scores=$uid&userId=$uid";

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
          print(map["server_response"][0]["Score_ID"]);


          for (var i = 0; i < size; i++) {
            var moonLanding = DateTime.parse(map["server_response"][i]["Date"]);
            print(DateFormat.yMMMd().format(DateTime.now()));

            var diff=DateTime.now().difference(moonLanding);
            int diffDays=diff.inDays;

            String statustype="1";
            String status="Current";
            double ttlScore=double.parse(map["server_response"][i]["Total_Score"]);

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


            Map<String, String> mapX = {
              "name":  "${widget.mapList["names"]}",
              "age": map["server_response"][i]["Age"],
              "date":date,
              "status": status,
              "statustype": statustype,
              "total_scores": map["server_response"][i]["Total_Score"],
              "shuttle": map["server_response"][i]["Meters"],
              "squats": map["server_response"][i]["Squats"],
              "legRise": map["server_response"][i]["Leg_raises"],
              "pushups": map["server_response"][i]["Pushups"],
              "shuttle_Grade": map["server_response"][i]["Meters_Grade"],
              "squats_Grade": map["server_response"][i]["Squats_Grade"],
              "legRise_Grade": map["server_response"][i]["Leg_raises_Grade"],
              "pushups_Grade": map["server_response"][i]["Pushup_Grade"],
            };
            scoresMap.add(mapX);
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

  List<Map<String, String>> scoresMap = [];
  PageController controller = PageController(initialPage: 0);
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
          "Trainee Score",
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
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
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
                          color: kPrimaryColor,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
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
                          color: kPrimaryColor,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }


@override
void dispose() {
  controller.dispose();
  super.dispose();
}

PageView upDownPageView() {
  return PageView.builder(
    controller: controller,
    itemBuilder: (context, position) {
      if (position == currentPageValue.floor()) {
        return Transform(
          transform: Matrix4.identity()..rotateX(currentPageValue - position),
          child: scorePageMethod(scoresMap[position]),
        );
      } else if (position == currentPageValue.floor() + 1) {
        return Transform(
          transform: Matrix4.identity()..rotateX(currentPageValue - position),
          child: scorePageMethod(scoresMap[position]),
        );
      } else {
        return scorePageMethod(scoresMap[position]);
      }
    },
    itemCount: scoresMap.length,
  );
}

Container scorePageMethod(Map<String, String> map) {
  int statustype = int.parse(map["statustype"].toString());
  return Container(
    child: Stack(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                map["name"].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(25),
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                map["age"].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                map["date"].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                map["status"].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  color: statustype == 1
                      ? kPrimaryColor
                      : statustype == 2
                      ? kTextGoldColor
                      : kTextRedColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                map["total_scores"].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(50),
                  color: kTextGreenColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Shuttle",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Squats",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Leg-Raises",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Push-Ups",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "=",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "=",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "=",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "=",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            map["shuttle"].toString()+" "+map["shuttle_Grade"].toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: kTextGreenColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            map["squats"].toString()+" "+map["squats_Grade"].toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: kTextGreenColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            map["legRise"].toString()+" "+map["legRise_Grade"].toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: kTextGreenColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            map["pushups"].toString()+" "+map["pushups_Grade"].toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: kTextGreenColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),

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
