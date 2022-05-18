import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class QuesFour extends StatefulWidget {
  QuesFour({Key? key}) : super(key: key);

  @override
  _QuesFourState createState() => _QuesFourState();
}

class _QuesFourState extends State<QuesFour> {
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
          "Application",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Text(
                    "4 of 4",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Upload a recent photo of yourself.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: getProportionateScreenHeight(120),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    DefaultButton(
                        text: "Upload Photo",
                        press: () {
                          Navigator.pop(context);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => QuesFour()));
                        },
                        clr: kTextGreenColor,
                        isInfinity: true),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
