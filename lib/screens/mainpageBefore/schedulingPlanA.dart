import 'package:cross_comp/screens/mainpageBefore/accountPage.dart';
import 'package:cross_comp/screens/mainpageBefore/whenPage.dart';
import 'package:cross_comp/screens/mainpageBefore/whereMap.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'dialogBoxs/informed_consent.dart';
import 'dialogBoxs/medical_excercise_patterns.dart';
import 'dialogBoxs/medical_history.dart';
import 'dialogBoxs/medical_symptoms.dart';
import 'failedMedical.dart';

class SchedulingPlanAPage extends StatefulWidget {
  const SchedulingPlanAPage({Key? key}) : super(key: key);

  @override
  _SchedulingPlanAPageState createState() => _SchedulingPlanAPageState();
}

class _SchedulingPlanAPageState extends State<SchedulingPlanAPage> {
  bool initX = false;
  bool mStatus = false;
  bool consent = false;
  bool where = false;
  bool hQ1 = false;
  bool hQ2 = false;
  bool hQ3 = false;

  bool isPaid = false;
  @override
  void initState() {
    super.initState();
    getHQState();
  }

  getHQState() async {
    await HelperFunction.getInitSharedPreference().then((value) {
      if (value != null)
        setState(() {
          initX = value;
          print("initX  :  $value");
        });
    });

    await HelperFunction.getMStatusSharedPreference().then((value) {
      if (value != null)
        setState(() {
          mStatus = value;
          print("MStatus  :  $value");
        });
    });
    await HelperFunction.getConsentSharedPreference().then((value) {
      if (value != null)
        setState(() {
          consent = value;
          print("consent  :  $value");
        });
    });
    await HelperFunction.getWhereSharedPreference().then((value) {
      if (value != null)
        setState(() {
          where = true;
          print("consent  :  $value");
        });
    });


    await HelperFunction.getHQ1SharedPreference().then((value) {
      if (value != null)
        setState(() {
          hQ1 = value;
          print("hQ1  :  $value");
        });
    });
    await HelperFunction.getHQ2SharedPreference().then((value) {
      if (value != null)
        setState(() {
          hQ2 = value;
          print("hQ2  :  $value");
        });
    });
    await HelperFunction.getHQ3SharedPreference().then((value) {
      if (value != null)
        setState(() {
          hQ3 = value;
          print("hQ3  :  $value");
        });
    });
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
          "Scheduling",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Container(
                child: isPaid
                    ? Column(
                        children: [
                          SizedBox(height: getProportionateScreenHeight(50)),
                          Text(
                            "To track your progress towards your fitness goal,",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          Text(
                            "simply schedule a follow-up CrossComp!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(15)),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: getProportionateScreenHeight(50)),
                          Text(
                            "Schedule your first CrossComp for FREE!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(15)),


                        ],
                      ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: getProportionateScreenHeight(15)),
                  GestureDetector(
                    onTap: () {
                      if (!mStatus) {
                        (initX)
                            ? (hQ1)
                                ? Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FailedMedical()))
                                : (!hQ2 & hQ3)
                                    ? hQ1Method(context)
                                    : Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FailedMedical()))
                            : hQ1Method(context);
                      }
                    },
                    child: Text(
                      "1. Screening",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: TextStyle(
                        color: mStatus
                            ? Colors.black87
                            : initX
                                ? (hQ1)
                                    ? kTextRedColor
                                    : (!hQ2 & hQ3)
                                        ? kTextGreenColor
                                        : kTextRedColor
                                : kTextGreenColor,
                        fontSize: getProportionateScreenHeight(25),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  GestureDetector(
                    onTap: () {
                      print(mStatus);
                      if (mStatus) {
                        if (!consent) {
                          showDialog(
                            context: context,
                            builder: (_) => PopUpInformedConsent(
                              pressNo: () {
                                Navigator.pop(_);
                              },
                              pressYes: () {

                                stateMethod(_);
                                HelperFunction.saveConsentSharedPreference(true);
                              },
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      "2. Consent",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: TextStyle(
                        color: consent
                            ? Colors.black
                            : mStatus
                                ? kTextGreenColor
                                : kPrimaryColor,
                        fontSize: getProportionateScreenHeight(25),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: isPaid ? getProportionateScreenHeight(15) : 0),
                  Container(
                    child: isPaid
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AccountPage()));
                            },
                            child: Text(
                              "Account",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: getProportionateScreenHeight(25),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  GestureDetector(
                    onTap: () {
                      if (mStatus) {
                        if (consent) {
                          // if (!where) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WhereMap()));
                          // }
                        }
                      }
                    },
                    child: Text(
                      "3. Where & When",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color:  consent
                                ? kTextGreenColor
                                : kPrimaryColor,
                        fontSize: getProportionateScreenHeight(25),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Visibility(visible: false,
                    child: GestureDetector(
                      onTap: () {
                        if (where) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => WhenPage()));
                        }
                      },
                      child: Text(
                        "4. When",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenHeight(25),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void hQ1Method(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => PopUpSymptoms(
        pressNo: () {
          HelperFunction.saveHQ1SharedPreference(false);
          Navigator.pop(_);
          hQ2Method(context, false);
        },
        pressYes: () {
          HelperFunction.saveHQ1SharedPreference(true);

          Navigator.pop(_);
          hQ2Method(context, true);
        },
      ),
    );
  }

  void hQ2Method(BuildContext context, bool hq1) {
    showDialog(
      context: context,
      builder: (_) => PopUpExcercisePattern(
        pressNo: () {
          HelperFunction.saveHQ2SharedPreference(false);
          Navigator.pop(_);
          hQ3Method(context, hq1, false);
        },
        pressYes: () {
          HelperFunction.saveHQ2SharedPreference(true);

          Navigator.pop(_);
          hQ3Method(context, hq1, true);
        },
      ),
    );
  }

  void hQ3Method(BuildContext context, bool hq1, bool hq2) {
    showDialog(
      context: context,
      builder: (_) => PopUpMedicalHistory(
        pressNo: () {
          if (!hq1) {
            HelperFunction.saveUserMStatusSharedPreference(true);
          }
          HelperFunction.saveHQ3SharedPreference(false);
          stateMethod(_);
        },
        pressYes: () {
          if (!hq1) {
            if (hq2) HelperFunction.saveUserMStatusSharedPreference(true);
          }
          stateMethod(_);
          HelperFunction.saveHQ3SharedPreference(true);
        },
      ),
    );
  }

  void stateMethod(BuildContext _) {
    HelperFunction.saveInitSharedPreference(true);
    Navigator.pop(_);
    setState(() {
      getHQState();
    });
  }
}
