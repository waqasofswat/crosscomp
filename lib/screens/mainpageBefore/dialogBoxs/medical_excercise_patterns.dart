import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class PopUpExcercisePattern extends StatefulWidget {
  final Function() pressYes;
  final Function() pressNo;
  PopUpExcercisePattern({required this.pressNo, required this.pressYes});

  @override
  _PopUpExcercisePatternState createState() => _PopUpExcercisePatternState();
}

class _PopUpExcercisePatternState extends State<PopUpExcercisePattern>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  Tween<double> marginTopTween = Tween<double>(begin: 300, end: 280);
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
          child: Stack(
            children: [
              Column(
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
                        "Screening",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          "2 of 3",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(20),
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          "Have you been excercising regularly?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(20),
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          "'Regular excercise' is at least:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "30 minutes per day,",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "3 days per week,",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "for the past 3 months.",
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
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // height: 250,
                  padding: EdgeInsets.all(10),
                  child: Row(
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
                ),
              )
            ],
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
