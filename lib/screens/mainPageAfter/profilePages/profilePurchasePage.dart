import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class ProfilePurchasePage extends StatefulWidget {
  ProfilePurchasePage({Key? key}) : super(key: key);

  @override
  _ProfilePurchasePageState createState() => _ProfilePurchasePageState();
}

class _ProfilePurchasePageState extends State<ProfilePurchasePage> {
  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  /// This holds the items

  List<Map<String, String>> _timimg = [
    {"date": "04/12/2021", "price": "\$15.00, CC-6131", "title": "CrossComp 3"},
    {"date": "05/06/2021", "price": "\$18.00, CC-6133", "title": "Training 4"}
  ];

  /// This holds the item count
  int counter = 0;

  Widget animatedTile(BuildContext context, int index, animation) {
    Map<String, String> timimg = _timimg[index];
    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return curverMethod(animation, timimg, textStyle);
  }

  SlideTransition curverMethod(
      animation, Map<String, String> item, TextStyle textStyle) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: InkWell(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4, // 60% of space => (6/(6 + 4))
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      item["date"].toString(),
                      textAlign: TextAlign.start,
                      style: textStyle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6, // 60% of space => (6/(6 + 4))
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          item["price"].toString(),
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          item["title"].toString(),
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
          "Purchase",
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
        padding: EdgeInsets.all(8.0),
        child: AnimatedList(
          key: listKey,
          initialItemCount: _timimg.length,
          itemBuilder: (context, index, animation) {
            return animatedTile(context, index, animation); // Refer step 3
          },
        ),
      ),
    );
  }
}
