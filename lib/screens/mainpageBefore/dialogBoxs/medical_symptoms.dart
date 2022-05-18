import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class PopUpSymptoms extends StatefulWidget {
  final Function() pressYes;
  final Function() pressNo;
  PopUpSymptoms({required this.pressNo, required this.pressYes});

  @override
  _PopUpSymptomsState createState() => _PopUpSymptomsState();
}

class _PopUpSymptomsState extends State<PopUpSymptoms>
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
              EdgeInsets.only(top: 80, left: 20.0, right: 20.0, bottom: 10.0),
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
                        "Symptoms",
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
                        SizedBox(height: getProportionateScreenHeight(15)),
                        Text(
                          "1 of 3",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(20),
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(14)),
                        Text(
                          "Do you experiance any of the following symptoms?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(20),
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          "Chest Discomfort with or without exertion",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          "Unreasonable Breathlessness",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          "Dizziness, Fainting, Blackouts",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          "Ankle Swelling",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          "Forceful, Rapid, or Irregular Heat Beats",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          "Burning or Cramping in calves when walking",
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
