import 'dart:ui';

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

class _PopUpInformedConsentState extends State<PopUpInformedConsent> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  Tween<double> marginTopTween = Tween<double>(begin: 300, end: 250);
  late Animation<double> marginTopAnimation;
  var ischecked = false;
  var consentError = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
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
          margin: EdgeInsets.only(top: 100, left: 20.0, right: 20.0, bottom: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    color: kPrimaryColor,
                  ),
                  width: double.infinity,
                  height: 60,
                  child: Center(
                    child: Text(
                      "Consent Form",
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
                    /*Text(
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
                    SizedBox(height: getProportionateScreenHeight(20)),*/

                    Text(
                      "2. Informed Consent",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '1. Purpose and Explanation - ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'CrossComps are standardized fitness tests that are proctored by a certified CrossComp Judge. Each CrossComp involves a series of basic exercises. The objective of each CrossComp is to determine your physical functional capacity, generate an appropriate exercise prescription, and track your progress towards your personal fitness goals. CrossComps are recommended every one to three months depending on your fitness level and training program. Participation is voluntary.'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '2 Instructions - ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'You are expected to modify each exercise to the best of your capability and to set your own pace to whatever intensity level is comfortable for you. You may stop your CrossComp at any time for any reason. Your CrossComp Judge may encourage you to slow-down or even insist that you stop, depending on the signs of exertion or discomfort that you exhibit during your CrossComp.'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '2. Attendant Discomforts and Risks - ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'There is the possibility of certain physiological changes occurring during your CrossComp. These include shortness of breath, pounding heart beats, palpitations, dizziness, fatigue, impaired coordination, and in extremely rare instances, heart attack, stroke, or death.'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '3. Your Responsibilities - ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'It is important for you to have answered the screening questions accurately regarding any pre-existing cardio-pulmonary-vascular symptoms, your current exercise pattern, and your medical history. You are fully responsible for disclosing all symptoms that you experience during your CrossComp, such as pain, shortness of breath, or pressure, tightness, and/or heaviness in your chest, neck, jaw, back, and/or arms.'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '4. Benefits to Be Expected - ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'Upon completing your CrossComp, you will obtain an accurate Fitness Score and an appropriate Exercise Rx. Your CrossComp Score reflects: A) Your functional capacity, B) The effectiveness of your exercise program, and C) Your progress towards your fitness goal.'),
                             ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                'Your CrossComp Score also allows you to participate in CrossComps’ World-Wide, Life-Long Fitness Competition. Our customizable format is fun and motivating, and it is accessible through the CrossComp App.'),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                'If applicable, your doctor may use your CrossComp Score to better manage sedentary-related medical conditions in conjunction with your on-going medical treatment. Aggregate CrossComp data will be used for the advancement of exercise science and lifestyle therapies.'),


                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '5. Inquiries - ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'You are encouraged to get any desired clarifications regarding your CrossComp from your CrossComp Judge. You and your doctor, coach, or personal trainer are welcome to obtain more information about CrossComp procedures and scoring, as well as its many health and medical applications, by visiting www.CrossComps.com.'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '6. Use of Personal Information - ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'The information that is obtained during your CrossComp will be treated as privileged and confidential. It will not be released or revealed to any third party. Aggregate information will be used for statistical analysis and scientific research purposes while fully protecting your identity and right to privacy. Of course, you are always free to share your CrossComp Score and Exercise Rx with anyone you choose to do so.'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '7. Freedom of Consent - ', style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'Your voluntary participation in CrossComps acknowledges that you have read this informed consent and accept the attendant discomforts and risks. You understand: A) The procedures, B) You are free to stop your CrossComp at any time, and C) You had the opportunity to ask questions and get answers to your satisfaction.'),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: ischecked,
                          onChanged: (v) {
                            setState(() {
                              ischecked = v!;
                            });
                          },
                        ),
                        Flexible(
                          child: Text(
                            "I have read the Informed Consent items above, and I choose to participate in CrossComps.",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // height: 250,
                      padding: EdgeInsets.all(10),
                      child: Container(
                        // height: getProportionateScreenHeight(150),
                        child: Column(
                          children: [
                            Visibility(
                              visible: false,
                              child: Container(
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
                            ),
                            SizedBox(height: getProportionateScreenHeight(15)),
                            Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DefaultButton(
                                    text: "Submit",
                                    press: ischecked? widget.pressYes : widget.pressNo,
                                    clr: kPrimaryColor,
                                    isInfinity: false),
/*                                                   DefaultButton(
                                    text: "No",
                                    press: widget.pressNo,
                                    clr: kPrimaryColor,
                                    isInfinity: false),*/
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Visibility(
                                visible: consentError,
                                child: Text(
                                  "Please accept the Informed Consent",
                                  style: TextStyle(color: Colors.red),
                                ))
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
