import 'dart:convert';

import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  String userId;
  ProfilePage({Key? key,required this.userId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String fName = "Jon";
  String lName = "Opsahl";
  String partDate = "02/16/1721";
  String volDate = "04/16/1721";
  String profDate = "06/16/1721";
  String phone = "909-957-2730";
  String email = "DrOpsahl@gmail.com";
  String postalCode = "1011";
  String league = "Compassion Unlimited";
  String gender = "Male";

  String dob = "03/10/1960";
  String age = "61.05";
  String height = "5'08''";
  String weight = "148";
  String bmi = "23.4";
  bool isLoading =true;

  String conference = "Southeastern California";
  String union = "Pacific";
  String division = "North American";
  String city = "Riverside";
  String county = "California";
  String state = "Riverside";
  String country = "United States";
  String continent = "North American";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }
  Future<Map<String, dynamic>> getProfileData() async {
    print("getProfileData");


    String url = mainApiUrl + "?get_user=true&currentUserID=${widget.userId}";

    print(url);
    final response = await http.get(Uri.parse(url));
    // Map<String, String> header = {"Content-type": "multipart/form-data"};
    // final response = await http.post(
    //   Uri.parse(getScoresUrl),
    //   headers: header,
    //   body: {'getUser_Scores': "true", 'userId': UserId},
    // );

    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      if (response.body.toString().contains("Failure")) {
        print("response Failed");
        setState(() {
          // _loading = false;
          isLoading = false;
          // progress?.dismiss();
        });
      } else {
        // import 'dart:convert';

        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status'] == "failed") {
          setState(() {
            // _btnController.error();
            // progress?.dismiss();
            isLoading = false;
          });
        } else {

          try{

            print( map["server_response"]["First_Name"].toString());
            print( map["required_response"]["PostalCode"].toString());
            // if(
            // map["server_response"]["First_Name"].toString() != null
            // ){
            fName =  map["server_response"]["First_Name"].toString();
            lName =  map["server_response"]["Last_Name"].toString();
            partDate = map["server_response"][""].toString();
            volDate = map["server_response"][""].toString();
            profDate = map["server_response"][""].toString();
            phone = map["server_response"]["Phone"].toString();
            email = map["server_response"]["Email"].toString();

            postalCode =map["required_response"]["PostalCode"].toString();
            league = map["server_response"]["League"].toString();
            conference = map["server_response"][""].toString();
            union = map["server_response"][""].toString();

            division = map["server_response"][""].toString();
            city = map["required_response"]["City_Name"].toString();
            county =map["required_response"]["County_Name"].toString();
            state = map["required_response"]["State_Name"].toString();
            country = map["required_response"]["Country_Name"].toString();
            continent = map["server_response"][""].toString();
            dob = map["server_response"]["Date_Of_Birth"].toString();
            age = map["server_response"]["Age"].toString();
            height = map["server_response"]["Weight"].toString();
            weight = map["server_response"]["Height"].toString();

            double val = int.parse(weight)/int.parse(height);
            bmi =val.toString();

            // }
          }catch(e){
            print(e.toString());
            // showDialog(
            //     context: context,
            //     builder: (_) => OkDialog(
            //         pressOk: () {
            //
            //           Navigator.of(context).pop();
            //           Navigator.of(context).pop();
            //         },
            //
            //         title: "Error",
            //         message: "Sorry No Records in database"));
          }
          setState(() {
            isLoading = false;
          });
        }

        print("response Success");


      }
      return json.decode(response.body.toString());
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Trainee Profile",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading?Center(child: Loading() ,) :
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Text(
                    fName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(17),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Text(
                    lName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(17),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        partDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        volDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        profDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Text(
                    phone,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(17),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Text(
                    email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(17),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Text(
                    postalCode,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: getProportionateScreenHeight(17),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        league,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        gender,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        dob,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        age,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        height,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        weight,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        bmi,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),


              SizedBox(height: getProportionateScreenHeight(25)),
            ],
          ),
        ),
      ),
    );
  }
}
