import 'dart:convert';

import 'package:cross_comp/component/default_button.dart';
import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../homePage.dart';
import 'freeEventTrainingNavigation.dart';
import 'freeEventTrainingReservation.dart';

import 'package:http/http.dart' as http;
class FreeTrainingEventsFacilities extends StatefulWidget {
  bool isFacility;
  bool isEvent;
  String id;
  FreeTrainingEventsFacilities({required this.id,required this.isFacility,required this.isEvent}) ;

  @override
  _FreeTrainingEventsFacilitiesState createState() => _FreeTrainingEventsFacilitiesState();
}

class _FreeTrainingEventsFacilitiesState extends State<FreeTrainingEventsFacilities> {
  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  String UserId = "";
  bool isLoading=true;
  bool isFacility=false;
  bool isEvent=false;
  String id='0';
  String name='';
  String street='';
  String city='';
  String date='';
  String day='';
  String postalCode='';
  String selectedTimings='';
  bool isSelected=false;
  int indexSelected=-1;
  @override
  void initState() {
    super.initState();
    isFacility=widget.isFacility;
    isEvent=widget.isEvent;
    id=widget.id;
    getUserId();
  }
  /// This holds the items

  getUserId() async {
    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null)
        setState(() {

          UserId = value;
          print("UserId  :  $value");
          if(isFacility)
            getFacilitiesData();
          else
            getEventData();
        });
    });
  }

  Future<Map<String, dynamic>> getEventData() async {
    print("saveEventData");

    _timimg.clear();
    String url = mainApiUrl + "?get_single_event=true&id=$id";

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

            String id= map['server_response']["Event_ID"].toString();
            String title= map['server_response']["ParkSchoolName"].toString();

            name=title;
            street=map['server_response']["Street"].toString();
            city=map['server_response']["City_ID"].toString()+", "+map['server_response']["State_ID"].toString();

            postalCode=map['postalCode'].toString();
            day=map['server_response']["Day"].toString();
            date=map['server_response']["Date"].toString();
            Map<String, String> mapList={"title": title,"id":id};
            setState(() {
              setState(() {

                if(map['server_response']["hourBlock1"].toString().isNotEmpty)
                  _timimg.add({"day":day,"timing":map['server_response']["hourBlock1"].toString()});
                if(map['server_response']["hourBlock2"].toString().isNotEmpty)
                  _timimg.add({"day":day,"timing":map['server_response']["hourBlock2"].toString()});
                if(map['server_response']["hourBlock3"].toString().isNotEmpty)
                  _timimg.add({"day":day,"timing":map['server_response']["hourBlock3"].toString()});
                if(map['server_response']["hourBlock4"].toString().isNotEmpty)
                  _timimg.add({"day":day,"timing":map['server_response']["hourBlock4"].toString()});
                if(map['server_response']["hourBlock5"].toString().isNotEmpty)
                  _timimg.add({"day":day,"timing":map['server_response']["hourBlock5"].toString()});

              });
              // _timimg.add(mapList);
            });


          }catch(e){
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

  Future<Map<String, dynamic>> getFacilitiesData() async {
    print("saveEventData");

    _timimg.clear();
    String url = mainApiUrl + "?get_single_facility=true&id=$id";

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

            String id= map['server_response']["Facility_ID"].toString();
            String title= map['server_response']["GymName"].toString();
            name=title;
            street=map['server_response']["Street"].toString();
            city=map['server_response']["City_ID"].toString()+", "+map['server_response']["State_ID"].toString();

            date=map['server_response']["Date"].toString();
            postalCode=map['postalCode'].toString();
            Map<String, String> mapList={"title": title,"id":id};
            setState(() {
              int hoursListSize= map['hours_blocks'].length;
              print("asdfasd "+hoursListSize.toString());
              for(var i = 0; i< hoursListSize-1; i++) {
                print("aa ${map['hours_blocks'][i][2]}");

                _timimg.add({"day":"${map['hours_blocks'][i][2]}","timing": map['hours_blocks'][i][3].toString()+ " - "+ map['hours_blocks'][i][4].toString()  });
              }
             /* if(map['server_response']["monday_HB"].toString().isNotEmpty)
                _timimg.add({"day":"Monday","timing":map['server_response']["monday_HB"].toString()});
              if(map['server_response']["tuesday_HB"].toString().isNotEmpty)
                _timimg.add({"day":"Tuesday","timing":map['server_response']["tuesday_HB"].toString()});
              if(map['server_response']["wednesday_HB"].toString().isNotEmpty)
                _timimg.add({"Wednesday, "+"day":"Tuesday","timing":map['server_response']["wednesday_HB"].toString()});
              if(map['server_response']["thursday_HB"].toString().isNotEmpty)
                _timimg.add({"day":"Thursday","timing":map['server_response']["thursday_HB"].toString()});
              if(map['server_response']["friday_HB"].toString().isNotEmpty)
                _timimg.add({"day":"Friday","timing":map['server_response']["friday_HB"].toString()});
              if(map['server_response']["saturday_HB"].toString().isNotEmpty)
                _timimg.add({"day":"Saturday","timing":map['server_response']["saturday_HB"].toString()});
              if(map['server_response']["sunday_HB"].toString().isNotEmpty)
                _timimg.add({"day":"Sunday","timing":map['server_response']["sunday_HB"].toString()});
           */
            });


          }catch(e){
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

  Future<Map<String, dynamic>> saveReservation() async {
    print("saveEventData");

    String type="event";
    if(isFacility)
      type="facility";

    print(date);
    //selectedTimings=Uri.encodeComponent(selectedTimings);
    // String url = mainApiUrl + "?set_reservation=true&User_ID=$UserId&ef_id=$id&day=$day&date=$date&timing=$selectedTimings&type=$type";

    //print(url);
    //final response = await http.get(Uri.parse(url));
    // Map<String, String> header = {"Content-type": "multipart/form-data"};
    final response = await http.post(
      Uri.parse(mainApiUrl),
      //  headers: header,
      body: {
        'set_reservation': "true",
        'User_ID': UserId,
        'ef_id': id,
        'day': day,
        'date': date,
        'timing': selectedTimings,
        'type': type,
        'isFree': "0",
        'checkedIn': "0"
      },
    );

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

            String id= map["id"].toString();
            print("Reservation id : $id");
            setState(() {

              HelperFunction.saveWhenSharedPreference(true);
              HelperFunction.saveReservationSharedPreference(id);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => HomePage()),
                      (Route<dynamic> route) => false);
            });


          }catch(e){
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
  List<Map<String,String>> _timimg = [];

  /// This holds the item count
  int counter = 0;

  Widget animatedTile(BuildContext context, int index, animation) {
    Map<String,String> timimg = _timimg[index];
    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return curverMethod(animation, timimg, textStyle, index);
  }

  SlideTransition curverMethod(animation, Map<String,String> item, TextStyle textStyle,int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: GestureDetector(
        onTap: (){
          setState(() {
            isSelected=true;
            selectedTimings=item["timing"].toString();
            indexSelected=index;
            day=item["day"].toString();
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: indexSelected==index?kTextGreenColor:Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),

          child: Padding(
            padding:  EdgeInsets.all(5.0),
            child: SizedBox(
              height: 30.0,
              child: Text('___ ${item["timing"].toString()}', style: indexSelected==index? TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ):textStyle),
            ),
          ),
        ),
      ),
    );
  }


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
          "Free Training",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading ? Center(child: Loading(),):
      SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FreeEventTrainingNavigation()));
                  },
                  child: Column(
                    children: [
                      Text(
                        street,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: kTextGreenColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        city,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: kTextGreenColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        postalCode,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: kTextGreenColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  "Our next CrossComp Training is on:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  day+", "+date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      color: Colors.black87,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Text(
                  isEvent?"Select a Day":"Select a Day & Time:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "(You're welcome to train for upto 1 hour.)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: kTextRedColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Container(
                  height: _timimg.length * 50.0,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AnimatedList(
                        key: listKey,
                        initialItemCount: _timimg.length,
                        itemBuilder: (context, index, animation) {
                          return animatedTile(
                              context, index, animation); // Refer step 3
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(

                    padding: EdgeInsets.all(10),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultButton(
                            text: "Submit",
                            press: () {
                              if(isSelected){
                                setState(() {
                                  isLoading=true;
                                });
                                saveReservation();
                              }else{
                                var snackBar = SnackBar(content: Text('Select Timing'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            clr: isSelected ? kTextGreenColor : kSecondaryColor,
                            isInfinity: false),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        DefaultButton(
                            text: "Return to Map",
                            press: () {
                              Navigator.pop(context);
                            },
                            clr: kPrimaryColor,
                            isInfinity: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
