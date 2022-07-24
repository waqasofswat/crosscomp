import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/volunteerSignUpPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../../mainpageBefore/webPage.dart';

class OptiHealthPledgePage extends StatefulWidget {
  OptiHealthPledgePage({Key? key}) : super(key: key);

  @override
  _OptiHealthPledgePageState createState() => _OptiHealthPledgePageState();
}

class _OptiHealthPledgePageState extends State<OptiHealthPledgePage> {
  bool isLoading = false;
  var checked2Value=false;
  var checked1Value=false;
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
          "OptiHealth Pledge",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                "Click the link below to read and sign the",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              DefaultButton(
                  text: "OptiHealth Pledge",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebPage("https://www.optihealthnetwork.com/the-optihealth-pledge.html")));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => VolunteerSignUpPage()));
                  },
                  clr: kTextGreenColor,
                  isInfinity: true),
              SizedBox(height: getProportionateScreenHeight(15)),
              Row(
                children: [
                  Checkbox(value: checked1Value, onChanged: (val){
                    setState(() {
                      checked1Value = val!;
                    });
                  }),
                  Expanded(

                    child: Text(
                      "I read and signed the OptiHealth Pledge linked above.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Row(
                children: [
                  Checkbox(value: checked2Value, onChanged: (val){
                    setState(() {
                      checked2Value = val!;
                    });
                  }),
                  Flexible(
                    child: Text(
                      "I will work towards an OptiHealth Lifestyle to the best of my ability.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              if(checked1Value && checked2Value)...[
                DefaultButton(
                    text: "Submit",
                    press: () {
                      setState(() {
                        isLoading=true;
                      });
                      //updateUserType();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VolunteerSignUpPage(isSecondStep: true,)));
                    },
                    clr: kTextGreenColor,
                    isInfinity: true),
              ]else...[


                SizedBox(
                  width:double.infinity,
                  height: getProportionateScreenHeight(45),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: SelectedBorder(),
                      backgroundColor: MaterialStateProperty.all(Colors.black26),
                    ),
                    onPressed: null,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize:getProportionateScreenWidth(16),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // DefaultButton(
                //     text: "Submit",
                //     press:null,
                //     clr: kTextGreenColor,
                //     isInfinity: true),
              ],

            ],
          ),
        ),
      ),
    );
  }
}

