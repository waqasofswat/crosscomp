import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class VolunteerAllCoCaptains extends StatefulWidget {
  VolunteerAllCoCaptains({Key? key}) : super(key: key);

  @override
  _VolunteerAllCoCaptainsState createState() => _VolunteerAllCoCaptainsState();
}

class _VolunteerAllCoCaptainsState extends State<VolunteerAllCoCaptains> {
  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> _cocaptains = [
    {"names": "Andrew Smith", "type": "S", "status": false},
    {"names": "Kim Jones", "type": "S", "status": false},
    {"names": "Rebecca Torres", "type": "S", "status": false},
  ];

  Widget animatedTileO(BuildContext context, int index, animation,
      List<Map<String, dynamic>> item) {
    Map<String, dynamic> part = item[index];

    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return participantsRow(animation, part, textStyle);
  }

  SlideTransition participantsRow(
      animation, Map<String, dynamic> item, TextStyle textStyle) {
    bool isStatus = item["status"];
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => FacilityCheckIn()));
                  },
                  child: Text(
                    item["names"].toString(),
                    textAlign: TextAlign.start,
                    style: textStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => FacilityCheckIn()));
                  },
                  child: Text(
                    item["type"].toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      color: kTextGreenColor,
                      fontWeight: FontWeight.w900,
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
          "Co-Captains",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Mentone SDA Church",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: getProportionateScreenHeight(20),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Mark Foster",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              SizedBox(height: getProportionateScreenHeight(50)),
              Container(
                height: _cocaptains.length * 50.0,
                child: AnimatedList(
                  key: listKeyK,
                  initialItemCount: _cocaptains.length,
                  itemBuilder: (context, index, animation) {
                    return animatedTileO(
                        context, index, animation, _cocaptains); // Refer step 3
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
