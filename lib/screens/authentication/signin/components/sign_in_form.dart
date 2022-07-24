import 'dart:convert';

import 'package:async/async.dart';
import 'package:cross_comp/component/custom_surffix_icon.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/form_errors.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/homePage.dart';
import 'package:cross_comp/screens/mainpageBefore/mainPage.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final AsyncMemoizer<Map<String, dynamic>> _memoizer = AsyncMemoizer();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Future<Map<String, dynamic>> loginMethod() async {
    setState(() {
      isLoading = true;

    });
      String url = mainApiUrl +
          "?login_user=true&login_email=${emailController.text}&login_pass=${passwordController.text}";

      print(url);
      final response = await http.get(Uri.parse(url));

      print(response.statusCode.toString());
      print(response.body.toString());
      if (response.statusCode == 200) {
        if (response.body.toString().contains("Failure")) {
          print("response Failed");
          setState(() {
            // _loading = false;
            isLoading = false;
          });
        } else {
          // import 'dart:convert';

          Map<String, dynamic> map = jsonDecode(response.body);
          if (map['status'] == "failed") {
            setState(() {
              // _btnController.error();
              // progress?.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(map['msg']),
              ));

              //
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
            HelperFunction.saveUserPassSharedPreference(
                passwordController.text);
            HelperFunction.saveUserNameSharedPreference(
                "${map["server_response"][0]["First_Name"]} ${map["server_response"][0]["Last_Name"]}");

            HelperFunction.saveUserTypeSharedPreference( "${map["server_response"][0]["User_Type"]}");

            // _btnController.success();
            // progress?.dismiss();
            isLoading = false;
            getLogin();
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
        return json.decode(response.body);
      } else {
        // _btnController.error();
        // progress?.dismiss();
        isLoading = false;
        throw Exception('Failed to fetch data');
      }
  }

  Future<void> getLogin() async {
    await HelperFunction.getWhenSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          if (value) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false);
          }
        });
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Builder(
            builder: (context) => Form(
              key: _formKey,
              child: Column(
                children: [
                  buildEmailTextFormField(emailController: emailController),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  buildPasswordTextFormField(
                      passwordController: passwordController),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  CheckboxListTile(

                      activeColor: kPrimaryColor,
                      dense: true,
                      //font change
                      title: new Text(
                        "Remember Me",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.9),
                      ),
                      value:rememberMe,

                      onChanged: ( val) {
                        setState(() {
                          rememberMe = val!;
                        });
                      }),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  ErrorForm(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  // RoundedLoadingButton(
                  //   color: kTextGreenColor,
                  //   child: Text(
                  //     'Continue',
                  //     style: TextStyle(
                  //       fontSize: getProportionateScreenWidth(18),
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  //   controller: _btnController,
                  //   onPressed: () {
                  //     loginMethod();
                  //     // if (_formKey.currentState!.validate()) {
                  //     //   _formKey.currentState!.save();
                  //     // }
                  //   },
                  // ),
                  DefaultButton(
                    isInfinity: true,
                    clr: kGreenColor,

                    text: "Continue",
                    press: () {
                      loginMethod();
                      // if (_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();
                      // }
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
        _btnController.reset();
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

  TextFormField buildPasswordTextFormField(
      {required TextEditingController passwordController}) {
    return TextFormField(
      controller: passwordController,
      // onSaved: (newVal)=>passwordVar=newVal,
      obscureText: true,
      onChanged: (val) {
        _btnController.reset();
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
