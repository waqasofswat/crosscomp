import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int crossComps = 0;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  /// This holds the items
  List<String> _timimg = [
    "Monday, 9:00 - 11:00 am",
    "Tuesday, 1:00 - 3:00 pm",
    "Wednesday, 3:00 - 5:00 pm",
    "Thusrday, 6:00 - 8:00 pm"
  ];

  /// This holds the item count
  int counter = 0;
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
          "CrossComp Account",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Text(
                    "You have",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "$crossComps pre-paid CrossComps",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "in your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Text(
                    "Select your purchase below:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(35)),
                  newStatusMethod(crossComps),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: getProportionateScreenHeight(120),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    DefaultButton(
                        text: crossComps == 0 ? "PURCHASE" : "PROCEED",
                        press: () {
                          setState(() {
                            if (crossComps == 0) {
                              crossComps = 3;
                            } else {
                              crossComps = 0;
                            }
                          });
                        },
                        clr: kPrimaryColor,
                        isInfinity: true),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Container newStatusMethod(int crossComps) {
    return crossComps == 0
        ? Container(
            height: 250,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AnimatedList(
                    key: listKey,
                    initialItemCount: _timimg.length,
                    itemBuilder: (context, index, animation) {
                      return animatedTile(
                          context, index, animation); // Refer step 3
                    },
                  ),
                ),
              ),
            ),
          )
        : Container(
            child: Container(
              height: 250,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(25)),
                        Text(
                          "To Schedule a follow-up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "CrossComp, tap 'Proceed' below.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        Text(
                          "A pre-paid CrossComp will be",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "deducted from your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget animatedTile(BuildContext context, int index, animation) {
    String timimg = _timimg[index];
    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return curverMethod(animation, timimg, textStyle);
  }

  SlideTransition curverMethod(animation, String item, TextStyle textStyle) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: SizedBox(
        height: 30.0,
        child: Text('___ $item', style: textStyle),
      ),
    );
  }
}
