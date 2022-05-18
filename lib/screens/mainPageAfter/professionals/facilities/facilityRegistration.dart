import 'dart:convert';
import 'dart:math';

import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/models/hours_block_model.dart';
import 'package:cross_comp/models/postalCodesModel.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:cross_comp/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'myFacilities.dart';

class FacilityRegistration extends StatefulWidget {
  FacilityRegistration({Key? key}) : super(key: key);

  @override
  _FacilityRegistrationState createState() => _FacilityRegistrationState();
}

class _FacilityRegistrationState extends State<FacilityRegistration> {
  bool checkedValue = false;
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  String userId = "";
  String userName = "";
  bool isLoading = false;

  String facilityName = '';
  int postalCodeID = 0;
  String street = '';
  String day = '';
  String date = 'Select Date';
  String gymName = '';
  ValueNotifier<String> startTime = ValueNotifier('Start Time');
  ValueNotifier<String> endTime = ValueNotifier('End Time');
  //String endTime = 'End Time';
  String address = '';
  String mondayBlock = '1:00 PM - 3:00 PM';
  String tuesdayBlock = '3:00 PM - 5:00 PM';
  String wednesdayBlock = '5:00 PM - 7:00 PM';
  String thursdayBlock = '7:00 PM - 9:00 PM';
  String fridayBlock = '9:00 AM - 11:00 AM';
  String saturdayBlock = '7:00 AM - 9:00 AM';
  String sundayBlock = '9:00 AM - 11:00 AM';
  int hrBlk = 0;
  int hrBlk1 = 0;
  int hrBlk2 = 0;
  int hrBlk3 = 0;
  int hrBlk4 = 0;
  int hrBlk5 = 0;
  int hrBlk6 = 0;
  int hrBlk7 = 0;
  List<HoursBlock> hrsblock_list = [];
  List<String> listHrBlk = [];
  List<String> listHrBlk1 = [];
  List<String> listHrBlk2 = [];
  List<String> listHrBlk3 = [];
  List<String> listHrBlk4 = [];
  List<String> listHrBlk5 = [];
  List<String> listHrBlk6 = [];
  List<String> listHrBlk7 = [];
  double lat = 0.0;
  double lng = 0.0;

  bool isList = false;
  late List<PostalCodeModel> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    _time = TimeOfDay(hour: now.hour, minute: now.minute);
    print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());
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

    listHrBlk1.add("Enter Monday Hour Block");
    listHrBlk2.add("Enter Tuesday Hour Block");
    listHrBlk3.add("Enter Wednesday Hour Block");
    listHrBlk4.add("Enter Thursday Hour Block");
    listHrBlk5.add("Enter Friday Hour Block");
    listHrBlk6.add("Enter Saturday Hour Block");
    listHrBlk7.add("Enter Sunday Hour Block");

    listHrBlk.forEach((element) {
      listHrBlk1.add(element);
      listHrBlk2.add(element);
      listHrBlk3.add(element);
      listHrBlk4.add(element);
      listHrBlk5.add(element);
      listHrBlk6.add(element);
      listHrBlk7.add(element);
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
        list = (json.decode(response.body)['PostalCodeList'] as List).map((data) => PostalCodeModel.fromJson(data)).toList();
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
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print('_getUserLocation 2 ');
    try {
      print('_getUserLocation : try');
      List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);

      print('_getUserLocation : await');
      setState(() async {
        print('_getUserLocation : setstate ${position.latitude} ${position.longitude}');

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

  Future<Map<String, dynamic>>  saveFacilityData() async {
    print("saveFacilityData");

    int free = checkedValue ? 1 : 0;
    print("checkedValue $checkedValue");
    print("free $free");
/*    hrBlk1 == 0 ? mondayBlock = "" : mondayBlock = listHrBlk1[hrBlk1].toString();
    hrBlk2 == 0 ? tuesdayBlock = "" : tuesdayBlock = listHrBlk2[hrBlk2].toString();
    hrBlk3 == 0 ? wednesdayBlock = "" : wednesdayBlock = listHrBlk3[hrBlk3].toString();
    hrBlk4 == 0 ? thursdayBlock = "" : thursdayBlock = listHrBlk4[hrBlk4].toString();
    hrBlk5 == 0 ? fridayBlock = "" : fridayBlock = listHrBlk5[hrBlk5].toString();
    hrBlk6 == 0 ? saturdayBlock = "" : saturdayBlock = listHrBlk6[hrBlk6].toString();
    hrBlk7 == 0 ? sundayBlock = "" : sundayBlock = listHrBlk7[hrBlk7].toString();*/

    // String url = mainApiUrl + "?set_facility=true&User_ID=$userId&Facility_Name=$facilityName&PostalCode_ID=$postalCodeID&"+
    //     "Street=$street&Day=$day&Date=$date&gymName=$gymName&Start_Time=$startTime&End_Time=$endTime&address=$address&"+
    //     "mondayBlock=$mondayBlock&tuesdayBlock=$tuesdayBlock&wednesdayBlock=$wednesdayBlock&thursdayBlock=$thursdayBlock&"+
    //     "fridayBlock=$fridayBlock&saturdayBlock=$saturdayBlock&sundayBlock=$sundayBlock&lat=$lat&lng=$lng&isFree=$free";
    // url= Uri.encodeFull(url);
    // print(url);
    // final response = await http.get(Uri.parse(url));
    String listofblocks = jsonEncode(hrsblock_list);
    var b={
      'set_facility': "true",
      'User_ID': userId,
      'Facility_Name': facilityName,
      'PostalCode_ID': list[postalCodeID].postalCode_ID.toString(),
      'Street': street,
      'gymName': gymName,
      //       'Start_Time': startTime.value,
      //      'End_Time': endTime.value,
      'address': address,
      "hrblocks" :listofblocks ,
      // 'mondayBlock': mondayBlock,
      // 'tuesdayBlock': tuesdayBlock,
      // 'wednesdayBlock': wednesdayBlock,
      // 'thursdayBlock': thursdayBlock,
      // 'fridayBlock': fridayBlock,
      // 'saturdayBlock': saturdayBlock,
      // 'sundayBlock': sundayBlock,
      'lat': lat.toString(),
      'lng': lng.toString(),
      'isFree': free.toString()
    };
    Map<String, String> header = {"Content-type": "multipart/form-data"};
    final response = await http.post(
      Uri.parse(mainApiUrl),
      // headers: header,
      body: b,
    );
print("body : "+b.toString());
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyFacilities()));
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
    return (await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyFacilities()))) ?? false;
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
            startTime.value = newTime.format(context);
          } else {
            endTime.value = newTime.format(context);
          }
        });
      }
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
            "Facility Registration",
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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    "To Register your CrossComp Facility and have it appear on our Map, enter the following information:",
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
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextFormField(
                    onChanged: (txt) {
                      facilityName = txt;
                    },
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    initialValue: "",
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Enter Name of Facility',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: kTextGreenColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                          borderSide: BorderSide(width: 1, color: kTextGreenColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextFormField(
                    onChanged: (txt) {
                      gymName = txt;
                    },
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    initialValue: "",
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Enter Gym Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: kTextGreenColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /*  ElevatedButton(
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
                      ),*/
                      /*      ElevatedButton(
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
                      ),*/
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: buildPostalCodeSpinner(),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: SelectedBorder(),
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  ),
                  onPressed: () {
                    startTime.value="Start Time";
                    endTime.value="End Time";
                    Dialog errorDialog = Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
                      child: StatefulBuilder(
                        builder: (BuildContext dialogcontext, void Function(void Function()) ssetState) {
                     ValueNotifier<String> selectedValue=ValueNotifier("Select Day");
                       return   Container(
                            height: 250.0,
                            width: 300.0,
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Text("Add a Time Block",style: TextStyle(fontSize:getProportionateScreenWidth(22), ),),

                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: ValueListenableBuilder(
                                    valueListenable: selectedValue,

                                    builder: (BuildContext context,String selection, Widget? child) {
                                      return  DropdownButton(
                                        hint: selectedValue.value == null
                                            ? Text('Dropdown')
                                            : Text(selectedValue.value,
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        style: TextStyle(color: Colors.blue),
                                        items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'].map(
                                              (val) {
                                            return DropdownMenuItem<String>(
                                              value: val,
                                              child: Text(val),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: ( valu) {
                                          print(valu);

                                          setState(
                                                () {
                                              selectedValue.value = valu.toString();
                                              selectedValue.notifyListeners();
                                            },
                                          );
                                        },
                                      );
                                    },

                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [



                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shape: SelectedBorder(),
                                          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                                        ),
                                        onPressed: () async {
                                          final TimeOfDay? newTime = await showTimePicker(
                                            context: dialogcontext,
                                            initialTime: _time,
                                          );
                                          if (newTime != null) {
                                               setState(() {
                                              _time = newTime;

                                              startTime.value = newTime.format(dialogcontext);
                                            });
                                          }
                                        },
                                        child: ValueListenableBuilder(
                                          valueListenable: startTime,
                                          builder: (BuildContext context, String value, Widget? child) {
                                            return Text(
                                              value,
                                              style: TextStyle(
                                                fontSize: getProportionateScreenWidth(18),
                                                color: Colors.white,
                                              ),
                                            );

                                          },

                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shape: SelectedBorder(),
                                          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                                        ),
                                        onPressed: () async {
                                          final TimeOfDay? newTime = await showTimePicker(
                                            context: context,
                                            initialTime: _time,
                                          );
                                          if (newTime != null) {
                                            setState(() {
                                              _time = newTime;
                                              endTime.value = newTime.format(context);

                                            });
                                          }
                                        },
                                        child:ValueListenableBuilder(
                                          valueListenable: endTime,
                                          builder: (BuildContext context, String value, Widget? child) {
                                            return Text(
                                              value,
                                              style: TextStyle(
                                                fontSize: getProportionateScreenWidth(18),
                                                color: Colors.white,
                                              ),
                                            );

                                          },

                                        ),
                                      ),
                                    ],
                                  ),
                                ),






              /*                  Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                  child: buildHourBlockSpinner(1),
                                ),*/
                                //Padding(padding: EdgeInsets.only(top: 50.0)),
                                TextButton(
                                    onPressed: () {
                                      if( !selectedValue.value.toLowerCase().contains("select") && !startTime.value.toLowerCase().contains("start") && !endTime.value.toLowerCase().contains("end") ) {
                                        setState(() {
                                          hrsblock_list.add(HoursBlock(day_name: selectedValue.value, start: startTime.value, end: endTime.value));

                                        });
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Text(
                                      'Continue',
                                      style: TextStyle( fontSize: 18.0),
                                    ))
                              ],
                            ),
                          );
                        },

                      ),
                    );
                    showDialog(context: context, builder: (BuildContext context) => errorDialog);
                  },
                  child: Text(
                    "Add Hour Block",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white,
                    ),
                  ),
                ),

                ListView.builder(
                  primary: false,
                  itemBuilder: (BuildContext, index){

                    return Card(
                      child: ListTile(
                      //  leading: CircleAvatar(backgroundImage: AssetImage(hrsblock_list[index]),),
                        title: Text(hrsblock_list[index].day_name),
                        subtitle: Text(hrsblock_list[index].start+" - "+hrsblock_list[index].end),
                      ),
                    );
                  },
                  itemCount: hrsblock_list.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                ),

   /*             Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: buildHourBlockSpinner(1),
                ),*/
                /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: buildHourBlockSpinner(2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: buildHourBlockSpinner(3),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: buildHourBlockSpinner(4),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: buildHourBlockSpinner(5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: buildHourBlockSpinner(6),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: buildHourBlockSpinner(7),
                ),*/


/*                CheckboxListTile(
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
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),*/
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: DefaultButton(
                    text: "Submit",
                    press: () {
                      if(facilityName.length<1){
                        final snackBar = SnackBar(content: Text('Invalid Facility Name'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                      }
                      if(street.length<1){
                        final snackBar = SnackBar(content: Text('Invalid Street Name'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                      }
                      if(gymName.length<1){
                        final snackBar = SnackBar(content: Text('Invalid Gym Name'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                      }
                      if(hrsblock_list.length<1){
                        final snackBar = SnackBar(content: Text('Please add at least 1 Hour Block'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                      }

                      saveFacilityData();
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: kTextGreenColor, width: 1.0)),
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
                    // postalCodeID= int.parse(value.toString());

                    postalCodeID = int.parse(value.toString());
                    print(value);
                  });
                },
              ),
            )
          : Container(),
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
    } else if (hrBlkNo == 6) {
      hrBlkX = hrBlk6;
      listHrBlk6.forEach((element) {
        listHrBlkX.add(element);
      });
    } else if (hrBlkNo == 7) {
      hrBlkX = hrBlk7;
      listHrBlk7.forEach((element) {
        listHrBlkX.add(element);
      });
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: kTextGreenColor, width: 1.0)),
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
              } else if (hrBlkNo == 6) {
                hrBlk6 = hrBlkX;
              } else if (hrBlkNo == 7) {
                hrBlk7 = hrBlkX;
              }
              print(value);
            });
          },
        ),
      ),
    );
  }
}

class SelectedBorder extends RoundedRectangleBorder implements MaterialStateOutlinedBorder {
  @override
  OutlinedBorder resolve(Set<MaterialState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    );
  }
}
