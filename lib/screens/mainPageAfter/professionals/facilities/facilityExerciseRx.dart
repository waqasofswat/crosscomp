import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class FacilityExerciseRx extends StatefulWidget {
  FacilityExerciseRx({Key? key}) : super(key: key);

  @override
  _FacilityExerciseRxState createState() => _FacilityExerciseRxState();
}

class _FacilityExerciseRxState extends State<FacilityExerciseRx> {
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
          "Exercise Rx",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
