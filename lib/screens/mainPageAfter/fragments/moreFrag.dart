import 'package:cross_comp/screens/mainPageAfter/volunteer/affiliateVolPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MoreFrag extends StatefulWidget {
  MoreFrag({Key? key}) : super(key: key);

  @override
  _MoreFragState createState() => _MoreFragState();
}

class _MoreFragState extends State<MoreFrag> {
bool affiliateVisibility=true;

  Future<void> _read() async {
    String? usertype=await HelperFunction.getUserTypeSharedPreference();
if(usertype!.toLowerCase().contains("professional")){
  print("inside iff");
  setState(()  {
    affiliateVisibility=false;
  });
}else{
  print("heree "+usertype);

}


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _read();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {Fluttertoast.showToast(msg: "This feature is in development. Please check back later.");},
                child: Text(
                  "Invite",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {Fluttertoast.showToast(msg: "This feature is in development. Please check back later.");},
                child: Text(
                  "Sponsor",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {Fluttertoast.showToast(msg: "This feature is in development. Please check back later.");},
                child: Text(
                  "Virtual Training",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {Fluttertoast.showToast(msg: "This feature is in development. Please check back later.");},
                child: Text(
                  "CrossComp Gyms",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {Fluttertoast.showToast(msg: "This feature is in development. Please check back later.");},
                child: Text(
                  "Resources",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Visibility(
                visible: affiliateVisibility,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AffiliateVolPage()));
                  },
                  child: Text(
                    "Affiliate",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: kTextGreenColor,
                      fontSize: getProportionateScreenHeight(25),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
