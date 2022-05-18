import 'dart:convert';

import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/facilityAssistantTrainingSchedule.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectFreeTrainingFacility extends StatefulWidget {
  SelectFreeTrainingFacility({Key? key}) : super(key: key);

  @override
  _SelectFreeTrainingFacilityState createState() =>
      _SelectFreeTrainingFacilityState();
}

class _SelectFreeTrainingFacilityState
    extends State<SelectFreeTrainingFacility> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  bool isLoading=true;
  @override
  void initState() {

    super.initState();
    getFacilitiesData();
  }

  Future<Map<String, dynamic>> getFacilitiesData() async {
    print("saveEventData");

    _timimg.clear();
    String url = mainApiUrl + "?get_all_facility=true&isFree=1";

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
            int size= map['size'];
            for(int i=0; i<size; i++){

              String id= map['server_response'][i]["Facility_ID"].toString();
              String title= map['server_response'][i]["GymName"].toString();
              Map<String, String> mapList={"title": title,"id":id};
              setState(() {

                _timimg.add(mapList);
              });
            }

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

  /// This holds the items

  List<Map<String, String>> _timimg = [];
  int counter = 0;


  Widget animatedTile(BuildContext context, int index, animation) {
    Map<String, String> timimg = _timimg[index];
    TextStyle textStyle = TextStyle(
      fontSize: getProportionateScreenWidth(15),
      color: Colors.black87,
      fontWeight: FontWeight.normal,
    );
    return curverMethod(animation, timimg, textStyle);
  }

  SlideTransition curverMethod(
      animation, Map<String, String> item, TextStyle textStyle) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AssistantTrainerScheduleFacility(fid:  item["id"].toString(),)));
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: Text(
                item["title"].toString(),
                textAlign: TextAlign.start,
                style: textStyle,
              ),
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
          "Select a Free Training",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading?Center(child: Loading(),):
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(25)),
              Container(
                height: _timimg.length * 50.0,
                child: AnimatedList(
                  key: listKey,
                  initialItemCount: _timimg.length,
                  itemBuilder: (context, index, animation) {
                    return animatedTile(
                        context, index, animation); // Refer step 3
                  },
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
            ],
          ),
        ),
      ),
    );
  }
}
