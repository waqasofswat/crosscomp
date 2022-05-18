import 'dart:async';
import 'dart:convert';

import 'package:cross_comp/component/conformDialog.dart';
import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/okDialog.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

class JoinATeamSubCat extends StatefulWidget {
  final String teamName;
  JoinATeamSubCat({Key? key, required this.teamName}) : super(key: key);

  @override
  _JoinATeamSubCatState createState() => _JoinATeamSubCatState();
}

class _JoinATeamSubCatState extends State<JoinATeamSubCat> {
  String UserId = "";
  bool isLoading=true;
  List<String> autoComp=[];



  getUserId() async {

    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null)
        setState(() {
          UserId = value;
          print("UserId  :  $value");

          getAllTeams();
        });
    });
  }
  Future<Map<String, dynamic>> getAllTeams() async {
    print("getTeamScoresMethod");


    String url = mainApiUrl + "?getAllTeams=true&userID=$UserId";

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
            isLoading = false;
          });
        } else {

          try{

            int size = map["size"];
            for(int i =0; i<size; i++){
              autoComp.add(map["server_response"][i]["Team_Name"].toString());
            }

            // if(
            // map["team_Details"][0]["TeamName"].toString()!= null &&
            //     map["team_Details"][0]["TeamAddress"].toString()!= null &&
            //     map["team_ages"][0]["AVG(LatestScore)"].toString()!= null &&
            //     map["team_score"][0]["ScoreDate"].toString()!= null &&
            //     map["team_counts"][0]["TeamCounts"].toString()!= null
            // ){
            //
            //   teamName=map["team_Details"][0]["TeamName"].toString();
            //   teamScore=double. parse(double.parse(map["team_ages"][0]["AVG(LatestScore)"].toString()).toStringAsFixed(2)).toString();
            //   teamAddress=map["team_Details"][0]["TeamAddress"].toString();
            //   teamDate=map["team_score"][0]["ScoreDate"].toString();
            //   teamParticipant=map["team_counts"][0]["TeamCounts"].toString();
            // }
          }catch(e){print(e.toString());
          showDialog(
              context: context,
              builder: (_) => OkDialog(
                  pressOk: () {

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },

                  title: "Error",
                  message: "Sorry No Records in database"));
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();

  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedCity='';
  String text = "";
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
          "Join a ${widget.teamName} Team",
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
        child: Center(
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Enter the Name of Your ${widget.teamName}:",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: getProportionateScreenHeight(20),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: this._typeAheadController,
                    decoration: InputDecoration(
                        labelText: 'Name of ${widget.teamName}',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 3, color: kTextGreenColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(15),
                        )),
                ),
                suggestionsCallback: (pattern)  async {
                  Completer<List<String>> completer = new Completer();

                  completer.complete(autoComp);
                  return completer.future;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.toString()),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  this._typeAheadController.text = suggestion.toString();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a city';
                  }
                },
                onSaved: (value) => this._selectedCity = value.toString(),
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    onChanged: (txt) {
                      text = txt;
                    },
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    initialValue: text,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Name of ${widget.teamName}',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: kTextGreenColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
              ),
              Divider(
                  color: Colors.black, height: getProportionateScreenHeight(5)),
              SizedBox(height: getProportionateScreenHeight(15)),
              SizedBox(height: getProportionateScreenHeight(15)),
              SizedBox(height: getProportionateScreenHeight(15)),
              DefaultButton(
                  text: "Join",
                  press: () {
                    print(_typeAheadController.text);
                    if(autoComp.contains(_typeAheadController.text)){showDialog(
                        context: context,
                        builder: (_) => ConformDialog(
                            pressNo: (){
                          Navigator.of(context).pop();
                        },
                            pressYes: (){
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();                        },
                            title: "Congrats",
                            message: "You Have Successfully joined The Team"));
                     
                    }else{
                      showDialog(
                          context: context,
                          builder: (_) => OkDialog(
                              pressOk: () {

                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },

                              title: "Error",
                              message: "Sorry No Team in database"));
                    }
                  },
                  clr: kTextGreenColor,
                  isInfinity: false),
              SizedBox(height: getProportionateScreenHeight(15)),
            ],
          ),
        ),
      ),
    );
  }
}
