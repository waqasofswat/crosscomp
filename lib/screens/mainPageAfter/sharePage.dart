import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class SharePage extends StatefulWidget {
  final Map<String, dynamic> map;
  SharePage({required this.map});

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    int statustype = int.parse(widget.map["statustype"].toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Share",
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
            Center(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Text(
                    widget.map["name"].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    widget.map["age"].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Text(
                    widget.map["date"].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    widget.map["status"].toString(),
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
                    widget.map["total_scores"].toString(),
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
                        flex: 2,
                        child: Container(),
                      ),
                      Expanded(
                        flex:4,
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
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text(
                                widget.map["shuttle"].toString()+" "+widget.map["shuttle_Grade"].toString(),
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
                                widget.map["squats"].toString()+" "+widget.map["squats_Grade"].toString(),
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
                                widget.map["legRise"].toString()+" "+widget.map["legRise_Grade"].toString(),
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
                                widget.map["pushups"].toString()+" "+ widget.map["pushups_Grade"].toString(),
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
      ),
    );
  }
}
