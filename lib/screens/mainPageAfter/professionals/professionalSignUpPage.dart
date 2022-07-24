import 'package:cross_comp/screens/mainPageAfter/professionals/professionalAgreementPage.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/professionalApplicationQuestions/questionOne.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

class ProfessionalSignUpPage extends StatefulWidget {
  bool ApplicationUploaded;

  ProfessionalSignUpPage({Key? key, required bool this.ApplicationUploaded}) : super(key: key);

  @override
  _ProfessionalSignUpPageState createState() => _ProfessionalSignUpPageState();
}

class _ProfessionalSignUpPageState extends State<ProfessionalSignUpPage> {
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
          "Professional Sign-Up",
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
              SizedBox(height: getProportionateScreenHeight(50)),
              Text(
                "To become a Professional Affiliate with CrossComps, simply complete the 2 items below:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(widget. ApplicationUploaded==true)...[
                    Icon(
                      Icons.done,
                      color: Colors.blue,
                      size: 25.0,
                    ),
                  SizedBox(width: 15,),

                  ],

                  GestureDetector(
                    onTap: () {
                      if(widget. ApplicationUploaded==false)
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => QuesOne()));
                    },
                    child: Text(
                      "Application",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color:widget. ApplicationUploaded==false?kTextGreenColor:kPrimaryColor,
                        fontSize: getProportionateScreenHeight(25),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              GestureDetector(
                onTap: () {
                  if(widget. ApplicationUploaded==true)
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfessionalAgreementPage()));
                },
                child: Text(
                  "Professional Agreement",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: widget.ApplicationUploaded==true?kTextGreenColor:kPrimaryColor,
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
