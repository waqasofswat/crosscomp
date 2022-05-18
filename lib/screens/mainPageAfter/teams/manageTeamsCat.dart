import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';

class ManageTeamCat extends StatefulWidget {
  final String secondTitle;
  ManageTeamCat({Key? key, required this.secondTitle}) : super(key: key);

  @override
  _ManageTeamCatState createState() => _ManageTeamCatState();
}

class _ManageTeamCatState extends State<ManageTeamCat> {
  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> listKeyM = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> _cocaptains = [
    {"names": "Erin Reynolds", "type": "S", "typeX": "O", "status": false},
    {"names": "Joe Gerard", "type": "S", "typeX": "O", "status": false},
    {"names": "Mark Foster", "type": "S", "typeX": "O", "status": false},
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
                flex: 4,
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
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
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
                    item["typeX"].toString(),
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
          "Manage Team",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: getProportionateScreenHeight(50),
            child: Container(
              color: Colors.grey[400],
              child: Center(
                child: Text(
                  widget.secondTitle,
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
          ),
          SizedBox(height: getProportionateScreenHeight(50)),

          // create widgets for each tab bar here
          Expanded(
            child: Container(
              child: Container(
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
            ),

            // second tab bar viiew widget
          ),
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
