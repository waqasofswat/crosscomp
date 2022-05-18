import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/professionalApplicationQuestions/questionFour.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class QuesThree extends StatefulWidget {
  QuesThree({Key? key}) : super(key: key);

  @override
  _QuesThreeState createState() => _QuesThreeState();
}

class _QuesThreeState extends State<QuesThree> {
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
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "3 of 4",
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
                    "Briefly explain why you want to be a Professional Affiliate with CrossComps",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "---------------------------------------------",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  height: 200,
                  child: TextFormField(
                    onChanged: (txt) {},
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    initialValue: '',
                    decoration: InputDecoration(
                      labelText: 'Response',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "---------------------------------------------",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "(1,000 charater limit)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DefaultButton(
                      text: "Save & Continue",
                      press: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuesFour()));
                      },
                      clr: kTextGreenColor,
                      isInfinity: true),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DefaultButton(
                      text: "Save & Exit",
                      press: () {
                        Navigator.pop(context);
                      },
                      clr: kRedColor,
                      isInfinity: true),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
