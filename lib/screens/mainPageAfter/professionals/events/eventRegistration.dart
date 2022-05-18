import 'dart:convert';

import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/default_button_rect.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/models/postalCodesModel.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/events/myEvents.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class EventResgistration extends StatefulWidget {
  EventResgistration({Key? key}) : super(key: key);

  @override
  _EventResgistrationState createState() => _EventResgistrationState();
}

class _EventResgistrationState extends State<EventResgistration> {
  bool checkedValue = false;
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  String userId = "";
  String userName = "";
  bool isLoading = false;

  String eventName = '';
  int postalCodeID = 0;
  String street = '';
  String day = '';
  String date = 'Select Date';
  String parkName = '';
  String startTime = 'Start Time';
  String endTime = 'End Time';
  String address = '';
  String hourBlock1 = '1:00 PM - 3:00 PM';

  String hourBlock2 = '3:00 PM - 5:00 PM';

  String hourBlock3 = '5:00 PM - 7:00 PM';

  String hourBlock4 = '7:00 PM - 9:00 PM';

  String hourBlock5 = '9:00 PM - 11:00 PM';
  int hrBlk = 0;
  int hrBlk1 = 0;
  int hrBlk2 = 0;
  int hrBlk3 = 0;
  int hrBlk4 = 0;
  int hrBlk5 = 0;
  List<String> listHrBlk=[];
  List<String> listHrBlk1=[];
  List<String> listHrBlk2=[];
  List<String> listHrBlk3=[];
  List<String> listHrBlk4=[];
  List<String> listHrBlk5=[];

  double lat = 0.0;
  double lng = 0.0;

  bool isList = false;
  late List<PostalCodeModel> list;
  List<String> daysList=["Enter Day of Event","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
  int daysListSize=0;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    _time = TimeOfDay(hour: now.hour, minute: now.minute);
    print(now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString());

    getHrBlk();
    getUserId();
    _getUserLocation();
    postalCodesMethod();
  }

  getHrBlk() {
    listHrBlk.add('7:00 AM - 9:00 AM');
    listHrBlk.add('9:00 AM - 11:00 AM');
    listHrBlk.add('11:00 AM - 1:00 PM');
    listHrBlk.add('1:00 PM - 3:00 PM');
    listHrBlk.add('3:00 PM - 5:00 PM');
    listHrBlk.add('5:00 PM - 7:00 PM');
    listHrBlk.add('7:00 PM - 9:00 PM');
    listHrBlk.add('9:00 PM - 11:00 PM');

    listHrBlk1.add("Enter Hour Block 1");
    listHrBlk2.add("Enter Hour Block 2");
    listHrBlk3.add("Enter Hour Block 3");
    listHrBlk4.add("Enter Hour Block 4");
    listHrBlk5.add("Enter Hour Block 5");

    listHrBlk.forEach((element) {
      listHrBlk1.add(element);
      listHrBlk2.add(element);
      listHrBlk3.add(element);
      listHrBlk4.add(element);
      listHrBlk5.add(element);
    });
  }

  getUserId() async {
    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null)
        setState(() {
          userId = value;
          print("UserId  :  $value");
        });
    });
    await HelperFunction.getUserNameSharedPreference().then((value) {
      if (value != null)
        setState(() {
          userName = value;
          print("UserName  :  $value");
        });
    });
  }

  Future<Map<String, dynamic>> postalCodesMethod() async {
    isLoading = true;

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
      throw Exception('Failed to fetch data');
    }
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
    setState(() {
      isLoading = false;
    });
  }

  Future<Map<String, dynamic>> saveEventData() async {
    print("saveEventData");

    int free = checkedValue ? 1 : 0;
    print("checkedValue $checkedValue");
    print("free $free");

    hrBlk1==0?hourBlock1="":hourBlock1=listHrBlk1[hrBlk1].toString();
    hrBlk2==0?hourBlock2="":hourBlock2=listHrBlk2[hrBlk2].toString();
    hrBlk3==0?hourBlock3="":hourBlock3=listHrBlk3[hrBlk3].toString();
    hrBlk4==0?hourBlock4="":hourBlock4=listHrBlk4[hrBlk4].toString();
    hrBlk5==0?hourBlock5="":hourBlock5=listHrBlk5[hrBlk5].toString();


    String url = mainApiUrl +
        "?set_event=true&User_ID=$userId&Event_Name=$eventName&PostalCode_ID=${list[postalCodeID]}&Street=$street&Day=$day&Date=$date&ParkName=$parkName&Start_Time=$startTime&End_Time=$endTime&address=$address&hourBlock1=$hourBlock1&hourBlock2=$hourBlock2&hourBlock3=$hourBlock3&hourBlock4=$hourBlock4&hourBlock5=$hourBlock5&lat=$lat&lng=$lng&isFree=$free";

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
          try {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyEvents()));
          } catch (e) {
            print(e.toString());
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

  Future<bool> _onWillPop() async {
    return (await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyEvents()))) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    void _selectTime(bool isStarting) async {
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _time,
      );
      if (newTime != null) {
        setState(() {
          _time = newTime;
          if (isStarting) {
            startTime = newTime.format(context);
          } else {
            endTime = newTime.format(context);
          }
        });
      }
    }

    Future<void> _selectDate(BuildContext context) async {

      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          date=selectedDate.year.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.day.toString();
        });
    }


    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: kPrimaryColor,
          title: Text(
            "Event Registration",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
              fontSize: getProportionateScreenHeight(18),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: isLoading
            ? Center(child: Loading())
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Text(
                          "To Register your CrossComp Event and have it appear on our Map, enter the following information:",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: TextFormField(
                          onChanged: (txt) {
                            eventName = txt;
                          },
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          initialValue: "",
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: 'Enter Name of Event',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: kTextGreenColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: TextFormField(
                          onChanged: (txt) {
                            street = txt;
                          },
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          initialValue: "",
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: 'Enter Street Address',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: kTextGreenColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: TextFormField(
                          onChanged: (txt) {
                            parkName = txt;
                          },
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          initialValue: "",
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: 'Enter Park Name',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: kTextGreenColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: SelectedBorder(),
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                              ),
                              onPressed: () {
                                _selectTime(true);
                              },
                              child: Text(
                                startTime,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: SelectedBorder(),
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                              ),
                              onPressed: () {
                                _selectTime(false);
                              },
                              child: Text(
                                endTime,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child:DefaultButton(text: date, press: (){_selectDate(context);}, clr: kPrimaryColor, isInfinity: true)

                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: buildPostalCodeSpinner(),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: buildDaysSpinner(),
                      ),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: buildHourBlockSpinner(1),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: buildHourBlockSpinner(2),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: buildHourBlockSpinner(3),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: buildHourBlockSpinner(4),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: buildHourBlockSpinner(5),
                      ),
                      CheckboxListTile(
                        title: Text(
                          "__FREE TRAINING",
                          style: TextStyle(
                              color: kRedColor,
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold),
                        ),
                        value: checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                      Padding(
                        padding: EdgeInsets.all(32.0),
                        child: DefaultButton(
                          text: "Submit",
                          press: () {
                            saveEventData();
                          },
                          clr: kTextGreenColor,
                          isInfinity: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Container buildPostalCodeSpinner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kTextGreenColor, width: 1.0)),
      child: isList
          ? Center(
              child: DropdownButton(
                dropdownColor: Colors.grey[200],
                isExpanded: true,
                value: postalCodeID,
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
                    postalCodeID = int.parse(value.toString());
                    // postalCodeID= int.parse(value.toString());
                    print(value);
                    print(postalCodeID);
                  });
                },
              ),
            )
          : Container(),
    );
  }
  Container buildDaysSpinner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kTextGreenColor, width: 1.0)),
      child: Center(
              child: DropdownButton(
                dropdownColor: Colors.grey[200],
                isExpanded: true,
                value: daysListSize,
                items: [
                  for (int i = 0; i < daysList.length; i++)
                    DropdownMenuItem(
                      child: Text(
                        daysList[i],
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
                    daysListSize =int.parse(value.toString());
                    if(daysListSize!=0){
                      day=daysList[daysListSize];
                    }else
                      day="";
                    // postalCodeID= int.parse(value.toString());
                    print(value);
                  });
                },
              ),
            ),
    );
  }

  Container buildHourBlockSpinner(int hrBlkNo) {
    int hrBlkX = 0;
    late List<String> listHrBlkX = [];

    if (hrBlkNo == 1) {
      hrBlkX = hrBlk1;
      listHrBlk1.forEach((element) {
        listHrBlkX.add(element);
      });
    } else if (hrBlkNo == 2) {
      hrBlkX = hrBlk2;
      listHrBlk2.forEach((element) {
        listHrBlkX.add(element);
      });
    } else if (hrBlkNo == 3) {
      hrBlkX = hrBlk3;
      listHrBlk3.forEach((element) {
        listHrBlkX.add(element);
      });
    } else if (hrBlkNo == 4) {
      hrBlkX = hrBlk4;
      listHrBlk4.forEach((element) {
        listHrBlkX.add(element);
      });
    } else if (hrBlkNo == 5) {
      hrBlkX = hrBlk5;
      listHrBlk5.forEach((element) {
        listHrBlkX.add(element);
      });
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kTextGreenColor, width: 1.0)),
      child: Center(
        child: DropdownButton(
          dropdownColor: Colors.grey[200],
          isExpanded: true,
          value: hrBlkX,
          items: [
            for (int i = 0; i < listHrBlkX.length; i++)
              DropdownMenuItem(
                child: Text(
                  listHrBlkX[i].toString(),
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
              hrBlkX = int.parse(value.toString());
              // postalCodeID= int.parse(value.toString());

              if (hrBlkNo == 1) {
                hrBlk1 = hrBlkX;
              } else if (hrBlkNo == 2) {
                hrBlk2 = hrBlkX;
              } else if (hrBlkNo == 3) {
                hrBlk3 = hrBlkX;
              } else if (hrBlkNo == 4) {
                hrBlk4 = hrBlkX;
              } else if (hrBlkNo == 5) {
                hrBlk5 = hrBlkX;
              }
              print(value);
            });
          },
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
