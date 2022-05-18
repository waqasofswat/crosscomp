import 'dart:convert';

import 'package:cross_comp/component/custom_surffix_icon.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/form_errors.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/models/postalCodesModel.dart';
import 'package:cross_comp/screens/mainPageAfter/homePage.dart';
import 'package:cross_comp/screens/mainpageBefore/mainPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:geolocator/geolocator.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final AsyncMemoizer<Map<String, dynamic>> _memoizer = AsyncMemoizer();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final List<String> errors = [];
  int countryId = 0;
  int stateId = 0;
  int devisionId = 0;
  int cityId = 0;
  double lat = 0.0;
  double lng = 0.0;
  String address = "";
  int postalCodeId = 0;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController fnameController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String phoneText = "";
  String fnameText = "";
  String lnameText = "";
  String emailText = "";
  String passwordText = "";
  late List<PostalCodeModel> list;

  bool rememberMe = false;
  bool isList = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    postalCodesMethod();
  }

  void _getUserLocation() async {
    print('_getUserLocation');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print('_getUserLocation 2 ');
    try {
      print('_getUserLocation : try');
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      print('_getUserLocation : await');
      setState(() async {
        print(
            '_getUserLocation : setstate ${position.latitude} ${position.longitude}');

        print('${placemark[0].name}');
        // final coordinates =
        //     new Coordinates(position.latitude, position.longitude);
        // var addresses =
        //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
        // var first = addresses.first;
        // print("${first.featureName} : ${first.addressLine}");

        // address = Uri.encodeComponent("${first.addressLine}");
        lat = position.latitude;
        lng = position.longitude;
        // isLoading = false;
      });
    } catch (e) {
      print('_getUserLocation : error : $e');
      print(e);
    }
  }

  Future<Map<String, dynamic>> postalCodesMethod() {
    isLoading = true;
    return this._memoizer.runOnce(() async {
      String url = mainApiUrl + "?postalCode_Request=true";

      print(url);
      final response = await http.get(Uri.parse(url));
      // final response = await http.post(Uri.parse(url), body: {});

      print(response.statusCode.toString());
      print(response.body.toString());
      if (response.statusCode == 200) {
        setState(() {
          isList = true;
          list = (json.decode(response.body)['PostalCodeList'] as List)
              .map((data) => PostalCodeModel.fromJson(data))
              .toList();
          isLoading = false;
        });
        print("response Success: ${list[0].postalCode.toString()}");

        return json.decode(response.body.toString());
      } else {
        setState(() {
          isLoading=true;
        });
        throw Exception('Failed to fetch data');
      }
    });
  }

  Future<Map<String, dynamic>> signinMethod() async {
    print("signinMethod");
    print("firstName=$fnameText");
    print("lastName=$lnameText");
    print("phone=$phoneText");
    print("email=$emailText");
    print("password=$passwordText");
    print("postalCode=${list[postalCodeId].postalCode}");
    print("address=$address");
    print("lat=$lat");
    print("lng=$lng");

    String url = mainApiUrl +
        "?profile_registration=true&firstName=$fnameText&lastName=$lnameText&phone=$phoneText&email=$emailText&password=$passwordText&postalCode=${list[postalCodeId].postalCode}&address=$address&lat=$lat&lng=$lng";

    print(url);
    final response = await http.get(Uri.parse(url));
    // Map<String, String> header = {"Content-type": "multipart/form-data"};
    // final response = await http.post(
    //   Uri.parse(registrationUrl),
    //   headers: header,
    //   body: {
    //     'profile_registration': "true",
    //     'firstName': fnameText,
    //     'lastName': lnameText,
    //     'phone': phoneText,
    //     'email': emailText,
    //     'password': passwordText,
    //     'postalCode': list[postalCodeId].postalCode,
    //     "address": address,
    //     "lat": lat.toString(),
    //     "lng": lng.toString()
    //   },
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
print("res "+response.body);
        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status'] == "failed") {
          setState(() {
            // _btnController.error();
            // progress?.dismiss();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(map['msg']),
            ));
            isLoading = false;
            passwordController.text = "";
          });
        } else {
          print(map["server_response"][0]["First_Name"]);
          if (rememberMe) {
            HelperFunction.saveUserLoggedInSharedPreference(true);
          }
          HelperFunction.saveUserIdSharedPreference(
              "${map["server_response"][0]["User_ID"]}");
          HelperFunction.saveUserEmailSharedPreference(emailController.text);
          HelperFunction.saveUserPassSharedPreference(passwordController.text);
          HelperFunction.saveUserNameSharedPreference(
              "${map["server_response"][0]["First_Name"]} ${map["server_response"][0]["Last_Name"]}");
          // _btnController.success();
          // progress?.dismiss();
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainPage()),
                  (Route<dynamic> route) => false);
        }
        // String id = map['id'];
        // String org_id = map['org_id'];
        // String username = map['username'];
        // String password = map['password'];
        // String fcm_token = map['fcm_token'];
        // String status = map['status'];
        // HelperFunction.saveUserNameSharedPreference(username);
        // HelperFunction.saveUserStatusSharedPreference(status);
        // HelperFunction.saveIdSharedPreference(id);
        // HelperFunction.saveUserOrgIdSharedPreference(org_id);

        print("response Success");

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => MainPage(
        //             notificationsActionStreamSubscription:
        //                 widget.notificationsActionStreamSubscription)));

      }
      // return null;
      return json.decode(response.body.toString());
    } else {
      // _btnController.error();
      // progress?.dismiss();
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to fetch data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Builder(
            builder: (context) => Form(
              key: _formKey,
              child: Column(
                children: [
                  buildFirstTextFormField(fnameController: fnameController),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildLastTextFormField(lnameController: lnameController),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildPhoneTextFormField(phoneController: phoneController),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildEmailTextFormField(emailController: emailController),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildPasswordTextFormField(
                      passwordController: passwordController),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildPostalCodeSpinner(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      Text("Remember me"),
                      Spacer(),
                      // Text(
                      //   "Forgot Password",
                      //   style: TextStyle(decoration: TextDecoration.underline),
                      // )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  ErrorForm(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DefaultButton(
                    isInfinity: true,
                    clr: kGreenColor,
                    text: "Continue",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          isLoading = true;
                          signinMethod();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }

  TextFormField buildEmailTextFormField(
      {required TextEditingController emailController}) {
    return TextFormField(
      controller: emailController,
      //onSaved: (newVal)=>emailVar=newVal,
      keyboardType: TextInputType.emailAddress,
      onChanged: (val) {
        emailText = val;
        if (val.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(val) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(val) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
    );
  }

  TextFormField buildFirstTextFormField(
      {required TextEditingController fnameController}) {
    return TextFormField(
      controller: fnameController,
      //onSaved: (newVal)=>emailVar=newVal,
      keyboardType: TextInputType.name,
      onChanged: (val) {
        fnameText = val;
      },

      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your First Name",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildLastTextFormField(
      {required TextEditingController lnameController}) {
    return TextFormField(
      controller: lnameController,
      //onSaved: (newVal)=>emailVar=newVal,
      keyboardType: TextInputType.name,
      onChanged: (val) {
        lnameText = val;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your Last Name",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildPhoneTextFormField(
      {required TextEditingController phoneController}) {
    return TextFormField(
      controller: phoneController,
      //onSaved: (newVal)=>emailVar=newVal,
      keyboardType: TextInputType.number,
      onChanged: (val) {
        phoneText = val;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Phone.svg",
        ),
      ),
    );
  }

  Container buildCountrySpinner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: Colors.black, width: 1.0)),
      child: Center(
        child: DropdownButton(
            dropdownColor: Colors.grey[200],
            isExpanded: true,
            value: countryId,
            items: [
              // for (int i = 0; i < snapShot.length; i++)
              DropdownMenuItem(
                child: Text(
                  "Select Country",
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
                value: 0,
              ),
              DropdownMenuItem(
                child: Text(
                  "United States",
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
                value: 1,
              ),
            ],
            onChanged: (value) {
              setState(() {
                // countryId = int.parse(snapShot.indexOf(value.toString()).);
                countryId = int.parse(value.toString());
                print(value);
              });
            }),
      ),
    );
  }

  Container buildStateSpinner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: Colors.black, width: 1.0)),
      child: Center(
        child: countryId != 0
            ? DropdownButton(
                dropdownColor: Colors.grey[200],
                isExpanded: true,
                value: stateId,
                items: [
                  // for (int i = 0; i < snapShot.length; i++)
                  DropdownMenuItem(
                    child: Text(
                      "Select State",
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "Alabama",
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                    value: 1,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    // countryId = int.parse(snapShot.indexOf(value.toString()).);
                    stateId = int.parse(value.toString());
                    print(value);
                  });
                },
              )
            : Container(),
      ),
    );
  }

  Container buildDevisionSpinner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: Colors.black, width: 1.0)),
      child: Center(
        child: stateId != 0
            ? DropdownButton(
                dropdownColor: Colors.grey[200],
                isExpanded: true,
                value: devisionId,
                items: [
                  // for (int i = 0; i < snapShot.length; i++)
                  DropdownMenuItem(
                    child: Text(
                      "Select SubDevision",
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "Riverside",
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                    value: 1,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    // devisionId = int.parse(snapShot.indexOf(value.toString()).);
                    devisionId = int.parse(value.toString());
                    print(value);
                  });
                },
              )
            : Container(),
      ),
    );
  }

  Container buildCitySpinner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: Colors.black, width: 1.0)),
      child: Center(
        child: devisionId != 0
            ? DropdownButton(
                dropdownColor: Colors.grey[200],
                isExpanded: true,
                value: cityId,
                items: [
                  // for (int i = 0; i < snapShot.length; i++)
                  DropdownMenuItem(
                    child: Text(
                      "Select City",
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "Farza",
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                    value: 1,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    // countryId = int.parse(snapShot.indexOf(value.toString()).);
                    cityId = int.parse(value.toString());
                    print(value);
                  });
                },
              )
            : Container(),
      ),
    );
  }

  Container buildPostalCodeSpinner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: Colors.black, width: 1.0)),
      child: isList
          ? Center(
              child: DropdownButton(
                dropdownColor: Colors.grey[200],
                isExpanded: true,
                value: postalCodeId,
                items: [
                  for (int i = 0; i < list.length; i++)
                    DropdownMenuItem(
                      child: Text(
                        list[i].postalCode,
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      value: i,
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    // countryId = int.parse(snapShot.indexOf(value.toString()).);
                    // postalCodeId = int.parse(value.toString());

                    postalCodeId= int.parse(value.toString());
                    print(value);
                  });
                },
              ),
            )
          : Container(),
    );
  }

  TextFormField buildPasswordTextFormField(
      {required TextEditingController passwordController}) {
    return TextFormField(
      controller: passwordController,
      // onSaved: (newVal)=>passwordVar=newVal,
      obscureText: true,
      onChanged: (val) {
        passwordText = val;
        if (val.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (val.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (val) {
        if (val!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (val.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }
}










/*

                            FutureBuilder<List<Organization>>(
                                future: getAllById(),
                                builder: (context, snapShot) {
                                  return Container(
                                    height: 60.0,
                                    alignment: Alignment.centerLeft,
                                    decoration: kBoxDecorationStyle,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: snapShot.hasData
                                          ? DropdownButton(
                                              dropdownColor:
                                                  Theme.of(context).accentColor,
                                              isExpanded: true,
                                              value: org_id,
                                              items: [
                                                for (int i = 0;
                                                    i < snapShot.data!.length;
                                                    i++)
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      snapShot.data!
                                                          .elementAt(i)
                                                          .org_name,
                                                      style: kLabelStyle,
                                                    ),
                                                    value: int.parse(snapShot
                                                        .data!
                                                        .elementAt(i)
                                                        .org_id),
                                                  ),
                                              ],
                                              onChanged: (value) {
                                                setState(() {
                                                  org_id = int.parse(
                                                      value.toString());
                                                });
                                              })
                                          : Container(),
                                    ),
                                  );
                                }),
*/