import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class PopUpInformedConsent extends StatefulWidget {
  final Function() pressYes;
  final Function() pressNo;
  PopUpInformedConsent({required this.pressNo, required this.pressYes});

  @override
  _PopUpInformedConsentState createState() => _PopUpInformedConsentState();
}

class _PopUpInformedConsentState extends State<PopUpInformedConsent>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  Tween<double> marginTopTween = Tween<double>(begin: 300, end: 250);
  late Animation<double> marginTopAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    marginTopAnimation = marginTopTween.animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityTween.animate(controller),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          margin:
              EdgeInsets.only(top: 100, left: 20.0, right: 20.0, bottom: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: kPrimaryColor,
                  ),
                  width: double.infinity,
                  height: 60,
                  child: Center(
                    child: Text(
                      "Excercise Pattern",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text(
                      "Thank you for providing",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    Text(
                      "Medical Clearance from your physician in order to participate in CrossComps.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text(
                      "Now, we need your",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "Informed Consent.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: DefaultButton(
                          text: "Download & Read",
                          press: () {},
                          clr: kTextGreenColor,
                          isInfinity: true),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      "I have read the Informed Consent linked above, and i choose to participate in CrossComps",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      // height: 250,
                      padding: EdgeInsets.all(10),
                      child: Container(
                        // height: getProportionateScreenHeight(150),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              width: double.infinity,
                              height: getProportionateScreenHeight(150),
                              child: SfSignaturePad(
                                minimumStrokeWidth: 1,
                                maximumStrokeWidth: 3,
                                strokeColor: Colors.blue,
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(15)),
                            Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DefaultButton(
                                    text: "Yes",
                                    press: widget.pressYes,
                                    clr: kPrimaryColor,
                                    isInfinity: false),
                                DefaultButton(
                                    text: "No",
                                    press: widget.pressNo,
                                    clr: kPrimaryColor,
                                    isInfinity: false),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
