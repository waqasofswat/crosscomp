import 'dart:io';

import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../professionalSignUpPage.dart';


class QuesFour extends StatefulWidget {
  QuesFour({Key? key}) : super(key: key);

  @override
  _QuesFourState createState() => _QuesFourState();
}

class _QuesFourState extends State<QuesFour> {
late String ans1,ans2,ans3,userId;
  ImagePicker picker = ImagePicker();
bool isLoading = false;

  Future<void> _read() async {
     userId=await HelperFunction.getUserIdSharedPreference()??"";
     ans1=await HelperFunction.getPQ1SharedPreference()??"";
     ans2=await HelperFunction.getPQ2SharedPreference()??"";
     ans3=await HelperFunction.getPQ3SharedPreference()??"";

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _read();
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
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
                        press: () async {
                          XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          print("pp "+image!.name.toString());
                          setState(() {
                            isLoading = true;

                          });

                          Map<String, dynamic> fields = {
                            "q1": "Briefly explain how your participation in CrossComps has benefited you.",
                            "q2": "Briefly explain how volunteering with CrossComps has benefited other Participants.",
                            "q3": "Briefly explain why you want to be a Professional Affiliate with CrossComps",
                            "ans1": ans1,
                            "ans2": ans2,
                            "ans3": ans3,
                            "type": "Professional",
                            "user_id": userId,
                          };
                          var postUri = Uri.parse("https://crosscomp.edevz.com/appl-save.php");
                          var request = new http.MultipartRequest("POST", postUri);
                          fields.forEach((k, v) => request.fields[k] = v);
                          request.files.add(new http.MultipartFile.fromBytes('pic', await image.readAsBytes(),filename: "jpg", contentType:  new MediaType('image', 'jpeg')));

                          request.send().then((response) {
                            setState(() {
                              isLoading = false;

                            });
                            if (response.statusCode == 200) {
                              Fluttertoast.showToast(msg: "Application Uploaded");
                              print("Uploaded!");

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfessionalSignUpPage(
                                        ApplicationUploaded: true,
                                      )));
                            }
                            else{
                              Fluttertoast.showToast(msg: "Failed. Please try again");
                              Navigator.pop(context);
                            }
                          });
                          // Navigator.pop(context);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ProfessionalSignUpPage()));
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
