import 'dart:convert';

import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class TeamStanding extends StatefulWidget {
  final String teamCategory;
  TeamStanding({Key? key,required this.teamCategory}) : super(key: key);

  @override
  _TeamStandingState createState() => _TeamStandingState();
}

class _TeamStandingState extends State<TeamStanding> {

  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();
  bool isLoading=true;

  List<Map<String,String>> teamList=[];
  Future<Map<String, dynamic>> getTeamStandingMethod() async {
    print("getTeamScoresMethod");


    String url = mainApiUrl + "?teamStanding=true&teamCategory=${widget.teamCategory}";

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

          int size=map["size"];
          for(int i=0; i<size; i++){
            if(map["teamDetails"][i]["TeamName"]!= null){

              Map<String ,String> mapTeam={
                "name":map["teamDetails"][i]["TeamName"],
                "score":double. parse(double.parse(map["teamDetails"][i]["Score"].toString()).toStringAsFixed(2)).toString()
              };

                teamList.add(mapTeam);

            }

            // print(map["teamDetails"][0]["TeamName"]);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeamStandingMethod();
  }

  Widget animatedTileO(BuildContext context, int index, animation,
      List<Map<String, dynamic>> item) {
    Map<String, dynamic> part = item[index];

    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return teamStandingRow(animation, part, textStyle);
  }

  SlideTransition teamStandingRow(
      animation, Map<String, dynamic> item, TextStyle textStyle) {

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 14,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SharePage(
                    //           map: item,
                    //         )));
                  },
                  child: Text(
                    item["name"].toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color:  kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => FacilityCheckIn()));
                  },
                  child: Text(
                    item["score"].toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color:  kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              // Expanded(
              //   flex: 2,
              //   child: GestureDetector(
              //     onTap: () {
              //       showDialog(
              //         context: context,
              //         builder: (_) => ConformDialog(
              //             pressYes: () {},
              //             pressNo: () {
              //               Navigator.of(context).pop();
              //             },
              //             title: "Remove User",
              //             message: "Do you want to remove this person"),
              //       );
              //     },
              //     child: Image.asset(
              //       "assets/images/red_cross.png",
              //       height: getProportionateScreenHeight(15),
              //       width: getProportionateScreenWidth(15),
              //     ),
              //   ),
              // ),
              // Expanded(flex: 1, child: Container()),
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
          "My Team Score",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body:
      isLoading?
      Center(child: Loading()):
      Center(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Cities of Riverside County",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: getProportionateScreenHeight(20),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Center(
                    child: Text(
                      "August 9,2021",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
                color: Colors.black, height: getProportionateScreenHeight(5)),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [

                  Container(
                    height: teamList.length * 50.0,
                    child: AnimatedList(
                      key: listKeyK,
                      initialItemCount: teamList.length,
                      itemBuilder: (context, index, animation) {
                        return animatedTileO(
                            context, index, animation, teamList); // Refer step 3
                      },
                    ),
                  ),

                  SizedBox(height: getProportionateScreenHeight(50)),
                  Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(20)),
                    child: DefaultButton(
                      text: "Return to My Teams",
                      clr: kPrimaryColor,
                      isInfinity: true,
                      press: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
