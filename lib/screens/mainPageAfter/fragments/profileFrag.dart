import 'dart:convert';

import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/component/okDialog.dart';
import 'package:cross_comp/screens/authentication/authenticate.dart';
import 'package:cross_comp/screens/mainPageAfter/profilePages/profilePurchasePage.dart';
import 'package:cross_comp/screens/mainPageAfter/profilePages/profileServicesPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileFrag extends StatefulWidget {
  ProfileFrag({Key? key}) : super(key: key);

  @override
  _ProfileFragState createState() => _ProfileFragState();
}

class _ProfileFragState extends State<ProfileFrag> {
  String UserId = "";
  bool isLoading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  getUserId() async {

    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null)
        setState(() {
          UserId = value;
          print("UserId  :  $value");

          getProfileData();
        });
    });
  }
  Future<Map<String, dynamic>> getProfileData() async {
    print("getProfileData");


    String url = mainApiUrl + "?get_user=true&currentUserID=$UserId";

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
    if(response.body.toString().length>1023){
     print( response.body.toString().substring(1020));
    }
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
            print( map["server_response"]["Postal_Code"].toString());
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
            password = map["server_response"]["Password"].toString();
            postalCode =map["server_response"]["Postal_Code"].toString();
            league = map["server_response"]["League"].toString();
            conference = map["server_response"][""].toString();
            union = map["server_response"][""].toString();

            division = map["server_response"][""].toString();
            city = map["required_response"]["City_Name"].toString();
            county =map["required_response"]["County_Name"].toString();
            state = map["required_response"]["State_Name"].toString();
            country = map["required_response"]["Country_Name"].toString();
            continent = map["required_response"]["Continent_Name"].toString();
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

  Future<Map<String, dynamic>> upDateProfileData() async {
    print("getProfileData");


    String url = mainApiUrl + "?update_user=true&currentUserID=$UserId&firstName=$fName&lastName=$lName&phoneNumber=$phone&email=$email&postalCode=$postalCode";

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
            showDialog(
                context: context,
                builder: (_) => OkDialog(
                    pressOk: () {

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },

                    title: "Error",
                    message: map['msg']));
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
            password = map["server_response"]["Password"].toString();
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

  String fName = "Jon";
  String lName = "Opsahl";
  String partDate = "02/16/1721";
  String volDate = "04/16/1721";
  String profDate = "06/16/1721";
  String phone = "909-957-2730";
  String email = "DrOpsahl@gmail.com";
  String password = "7-characters";
  String postalCode = "1011";
  String league = "Compassion Unlimited";
  String conference = "Southeastern California";
  String union = "Pacific";

  String division = "North American";
  String city = "Riverside";
  String county = "California";
  String state = "Riverside";
  String country = "United States";
  String continent = "North American";
  String dob = "03/10/1960";
  String age = "61.05";
  String height = "5'08''";
  String weight = "148";
  String bmi = "23.4";

  // TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context, String hint, TextInputType type,
      int textNo, String text, bool isPass) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$hint'),
            content: TextFormField(
              onChanged: (txt) {
                if (textNo == 0) {
                  fName = txt;
                } else if (textNo == 1) {
                  lName = txt;
                } else if (textNo == 2) {
                  phone = txt;
                } else if (textNo == 3) {
                  email = txt;
                } else if (textNo == 4) {
                  password = txt;
                } else if (textNo == 5) {
                  postalCode = txt;
                }
              },
              obscureText: isPass ? true : false,
              keyboardType: type,
              initialValue: text,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Enter your $hint',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: kTextGreenColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            actions: <Widget>[
              ElevatedButton(


                onPressed: () {
                  setState(() {

                    Navigator.of(context).pop();
                    isLoading=true;

                  });
                  upDateProfileData();

                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                // style: ButtonStyle(
                //   shape: SelectedBorder(),
                //   backgroundColor: MaterialStateProperty.all(kTextGreenColor),
                // ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          isLoading? Center(child: Loading()) :
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "First Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            fName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: SelectedBorder(),
                          backgroundColor:
                              MaterialStateProperty.all(kTextGreenColor),
                        ),
                        onPressed: () {
                          _displayDialog(context, "First Name",
                              TextInputType.name, 0, fName, false);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.white,
                          ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            lName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: SelectedBorder(),
                          backgroundColor:
                              MaterialStateProperty.all(kTextGreenColor),
                        ),
                        onPressed: () {
                          _displayDialog(context, "Last Name",
                              TextInputType.name, 1, lName, false);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.white,
                          ),
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
                        "Joining as Participant",
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
                        "Joining as Volunteer",
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
                        "Joining as Professional",
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone #",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            phone,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: SelectedBorder(),
                          backgroundColor:
                              MaterialStateProperty.all(kTextGreenColor),
                        ),
                        onPressed: () {
                          _displayDialog(context, "Phone #",
                              TextInputType.number, 2, phone, false);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.white,
                          ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            email,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: SelectedBorder(),
                          backgroundColor:
                              MaterialStateProperty.all(kTextGreenColor),
                        ),
                        onPressed: () {
                          _displayDialog(context, "Email",
                              TextInputType.emailAddress, 3, email, false);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.white,
                          ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Password 7-charactors",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: SelectedBorder(),
                          backgroundColor:
                              MaterialStateProperty.all(kTextGreenColor),
                        ),
                        onPressed: () {
                          _displayDialog(context, "Password",
                              TextInputType.name, 4, password, true);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.white,
                          ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Postal Code",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            postalCode,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: SelectedBorder(),
                          backgroundColor:
                              MaterialStateProperty.all(kTextGreenColor),
                        ),
                        onPressed: () {
                          _displayDialog(context, "Postal Code",
                              TextInputType.number, 5, postalCode, false);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.white,
                          ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "League",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Conference",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            conference,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Union",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            union,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Division",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            division,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "City",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            city,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "County",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            county,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "State",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Country",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            country,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Continent",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            continent,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date of Birth",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Age",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Height",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Weight",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BMI",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenHeight(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.black),
              SizedBox(height: getProportionateScreenHeight(25)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: DefaultButton(
                    text: "SERVICES",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileServicePage()));
                    },
                    clr: kTextGreenColor,
                    isInfinity: true),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: DefaultButton(
                    text: "PURCHASES",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePurchasePage()));
                    },
                    clr: kTextGreenColor,
                    isInfinity: true),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: DefaultButton(
                    text: "LOGOUT",
                    press: () {

                      HelperFunction.saveUserLoggedInSharedPreference(false);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Authenticate()));
                    },
                    clr: kTextGreenColor,
                    isInfinity: true),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  @override
  OutlinedBorder resolve(Set<MaterialState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    );
  }
}
