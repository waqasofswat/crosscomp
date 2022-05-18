import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class FacilityScores extends StatefulWidget {
  FacilityScores({Key? key}) : super(key: key);

  @override
  _FacilityScoresState createState() => _FacilityScoresState();
}

class _FacilityScoresState extends State<FacilityScores> {
  List<Map<String, String>> scoresMap = [
    {
      "name": "Jon Opsahl",
      "age": "60.05",
      "date": "July 18,2021",
      "status": "Current",
      "statustype": "1",
      "total_scores": "104.3",
      "shuttle": "102.5",
      "squats": "94.5",
      "legRise": "113.3",
      "pushups": "106.7",
    },
    {
      "name": "Jon Khan",
      "age": "40.05",
      "date": "June 18,2021",
      "status": "Expiring",
      "statustype": "2",
      "total_scores": "104.3",
      "shuttle": "102.5",
      "squats": "94.5",
      "legRise": "113.3",
      "pushups": "106.7",
    },
    {
      "name": "Jon Malik",
      "age": "30.05",
      "date": "August 18,2021",
      "status": "Expired",
      "statustype": "3",
      "total_scores": "104.3",
      "shuttle": "102.5",
      "squats": "94.5",
      "legRise": "113.3",
      "pushups": "106.7",
    }
  ];

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
          "Scores",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
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
                      flex: 3,
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
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Text(
                              map["shuttle"].toString(),
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
                              map["squats"].toString(),
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
                              map["legRise"].toString(),
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
                              map["pushups"].toString(),
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
          Visibility(
            visible: false,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: getProportionateScreenHeight(170),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        DefaultButton(
                            text: "Share",
                            press: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SharePage(map: map)));
                            },
                            clr: kPrimaryColor,
                            isInfinity: false),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DefaultButton(
                            text: "Schedule",
                            press: () {},
                            clr: kTextGreenColor,
                            isInfinity: true),
                      ],
                    ))),
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
