import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';

class ManageTeam extends StatefulWidget {
  final String secondTitle;
  ManageTeam({Key? key, required this.secondTitle}) : super(key: key);

  @override
  _ManageTeamState createState() => _ManageTeamState();
}

class _ManageTeamState extends State<ManageTeam> {
  final GlobalKey<AnimatedListState> listKeyK = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> listKeyM = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> _cocaptains = [
    {"names": "Erin Reynolds", "type": "O", "status": false},
    {"names": "Joe Gerard", "type": "O", "status": false},
    {"names": "Mark Foster", "type": "O", "status": false},
  ];
  List<Map<String, dynamic>> _members = [
    {"names": "Alex Washington", "type": "S", "status": false},
    {"names": "Erin Reynolds", "type": "S", "status": false},
    {"names": "Frank Catalano", "type": "S", "status": false},
    {"names": "Joe Gerard", "type": "S", "status": false},
    {"names": "Larry Davis", "type": "S", "status": false},
    {"names": "Mark Foster", "type": "S", "status": false},
    {"names": "Rodney Bowes", "type": "S", "status": false},
    {"names": "Susan Hollingsead", "type": "S", "status": false},
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
                      color: kTextGreenColor,
                      fontWeight: FontWeight.w900,
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
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
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
              SizedBox(
                height: getProportionateScreenHeight(50),
                child: AppBar(
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  backgroundColor: kPrimaryColor,
                  bottom: TabBar(
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Center(
                          child: Text(
                            "Co-Captains",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenWidth(15)),
                          ),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: Text(
                            "Members",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenWidth(15)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    Container(
                      child: Container(
                        height: _cocaptains.length * 50.0,
                        child: AnimatedList(
                          key: listKeyK,
                          initialItemCount: _cocaptains.length,
                          itemBuilder: (context, index, animation) {
                            return animatedTileO(context, index, animation,
                                _cocaptains); // Refer step 3
                          },
                        ),
                      ),
                    ),

                    // second tab bar viiew widget
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: _members.length * 50.0,
                            child: AnimatedList(
                              key: listKeyM,
                              initialItemCount: _members.length,
                              itemBuilder: (context, index, animation) {
                                return animatedTileO(context, index, animation,
                                    _members); // Refer step 3
                              },
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: DefaultButton(
                                text: "Text to All",
                                press: () {},
                                clr: kTextGreenColor,
                                isInfinity: true),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
