import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainpageBefore/schedulePage.dart';
import 'package:cross_comp/screens/mainpageBefore/schedulingPlanA.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FailedMedical extends StatelessWidget {
  const FailedMedical({Key? key}) : super(key: key);

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
          "Medical Clearance",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Text(
                      "Based on your responses, you will need to get Medical Clearance from your physician in order to participate in CrossComps",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    DefaultButton(
                        text: "Dowmload & Print",
                        press: () {},
                        clr: kRedColor,
                        isInfinity: true),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    Text(
                      "our medical clearance form and talk to your doctor about it.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    Text(
                      "If your doctor provides Medical Clearance, take a photo of the signed form and upload it. Be sure all the spaces are filled and legible.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    DefaultButton(
                        text: "Take Photo",
                        press: () {
                          HelperFunction.saveUserMStatusSharedPreference(true);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SchedulingPlanAPage()));
                        },
                        clr: kTextGreenColor,
                        isInfinity: true),
                  ],
                ),
              ),
            ),
            RichText(
              text: LinkTextSpan(
                  url:
                      'http://docs.google.com/viewer?url=http://www.pdf995.com/samples/pdf.pdf',
                  text: 'Show My Pdf'),
            ),
          ],
        ),
      ),
    );
  }
}

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle? style, required String url, required String text})
      : super(
            style: style,
            text: text,
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                launch(url);
              });
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // height: 250,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultButton(
                text: "Upload Document Photo",
                press: () {},
                clr: kGreenColor,
                isInfinity: true),
          ],
        ),
      ),
    );
  }
}
