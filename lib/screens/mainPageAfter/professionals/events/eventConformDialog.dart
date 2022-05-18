import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class EventConformDialog extends StatefulWidget {
  final Function() pressYes;
  final Function() pressNo;
  final String title;
  final String message;
  EventConformDialog(
      {required this.pressYes,
      required this.pressNo,
      required this.title,
      required this.message});

  @override
  _EventConformDialogState createState() => _EventConformDialogState();
}

class _EventConformDialogState extends State<EventConformDialog>
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
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 230),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
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
                        widget.title,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(25)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(25)),
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
                          text: "Confirm",
                          press: widget.pressYes,
                          clr: kTextGreenColor,
                          isInfinity: false),
                      DefaultButton(
                          text: "Cancel",
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
