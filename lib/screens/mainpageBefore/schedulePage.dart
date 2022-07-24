import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'dialogBoxs/informed_consent.dart';
import 'dialogBoxs/medical_excercise_patterns.dart';
import 'dialogBoxs/medical_history.dart';
import 'dialogBoxs/medical_symptoms.dart';
import 'failedMedical.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool initX = false;
  bool hQ1 = false;
  bool hQ2 = false;
  bool hQ3 = false;
  @override
  void initState() {
    super.initState();
    getHQState();
  }

  getHQState() async {
    await HelperFunction.getInitSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          initX = value;
          print("initX  :  $value");
        });
      }else{
        print("initX null");
      }
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
          "Promotional Information about CrossComps",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(50)),
            GestureDetector(
              onTap: () {
                (hQ1 & hQ2 & hQ3)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FailedMedical()))
                    : hQ1Method(context);
              },
              child: Text(
                "Medical Screening",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: initX
                      ? (hQ1 & hQ2 & hQ3)
                          ? kRedColor
                          : kGreenColor
                      : kGreenColor,
                  fontSize: getProportionateScreenHeight(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            GestureDetector(
              onTap: () {
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
              },
              child: Text(
                "Informed Consent",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            GestureDetector(
              child: Text(
                "Service Providers",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
          ],
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
          hQ2Method(context);
        },
        pressYes: () {
          HelperFunction.saveHQ1SharedPreference(true);

          Navigator.pop(_);
          hQ2Method(context);
        },
      ),
    );
  }

  void hQ2Method(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => PopUpExcercisePattern(
        pressNo: () {
          HelperFunction.saveHQ2SharedPreference(false);
          Navigator.pop(_);
          hQ3Method(context);
        },
        pressYes: () {
          HelperFunction.saveHQ2SharedPreference(true);

          Navigator.pop(_);
          hQ3Method(context);
        },
      ),
    );
  }

  void hQ3Method(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => PopUpMedicalHistory(
        pressNo: () {
          HelperFunction.saveHQ3SharedPreference(false);
          stateMethod(_);
        },
        pressYes: () {
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
