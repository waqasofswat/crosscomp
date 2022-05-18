import 'dart:convert';

import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileServicePage extends StatefulWidget {
  ProfileServicePage({Key? key}) : super(key: key);

  @override
  _ProfileServicePageState createState() => _ProfileServicePageState();
}

class _ProfileServicePageState extends State<ProfileServicePage> {
  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();


  bool isLoading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProfileData();
  }
  // Future<Map<String, dynamic>> getProfileData() async {
  //   print("getProfileData");
  //
  //
  //   String url = servicesGetDataUrl + "?get_services=true";
  //
  //   print(url);
  //   final response = await http.get(Uri.parse(url));
  //   // Map<String, String> header = {"Content-type": "multipart/form-data"};
  //   // final response = await http.post(
  //   //   Uri.parse(getScoresUrl),
  //   //   headers: header,
  //   //   body: {'getUser_Scores': "true", 'userId': UserId},
  //   // );
  //
  //   print(response.statusCode.toString());
  //   print(response.body.toString());
  //   if (response.statusCode == 200) {
  //     if (response.body.toString().contains("Failure")) {
  //       print("response Failed");
  //       setState(() {
  //         // _loading = false;
  //         isLoading = false;
  //         // progress?.dismiss();
  //       });
  //     } else {
  //       // import 'dart:convert';
  //
  //       Map<String, dynamic> map = jsonDecode(response.body);
  //       if (map['status'] == "failed") {
  //         setState(() {
  //           // _btnController.error();
  //           // progress?.dismiss();
  //           isLoading = false;
  //         });
  //       } else {
  //
  //         try{
  //           int size = map["size"];
  //           for(int i=0; i<size; i++){
  //             Map<String,String> mapList= {
  //               "date": map["server_response"][i]["Timing_From"].toString(),
  //               "title": map["server_response"][i]["Name"].toString(),
  //               "address": map["server_response"][i]["Week_Days"].toString()
  //             };
  //             _timimg.add(mapList);
  //           }
  //           setState(() {
  //             isLoading=false;
  //           });
  //           // print( map["server_response"]["First_Name"].toString());
  //           // print( map["required_response"]["PostalCode"].toString());
  //
  //         }catch(e){
  //           print(e.toString());
  //
  //         }
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //
  //       print("response Success");
  //
  //
  //     }
  //     return json.decode(response.body.toString());
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     throw Exception('Failed to fetch data');
  //   }
  // }

  /// This holds the items

  List<Map<String, String>> _timimg = [];

  /// This holds the item count
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
      child: InkWell(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3, // 60% of space => (6/(6 + 4))
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      item["date"].toString(),
                      textAlign: TextAlign.start,
                      style: textStyle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7, // 60% of space => (6/(6 + 4))
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          item["title"].toString(),
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          item["address"].toString(),
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
          "Service",
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
      Container(
        padding: EdgeInsets.all(8.0),
        child: AnimatedList(
          key: listKey,
          initialItemCount: _timimg.length,
          itemBuilder: (context, index, animation) {
            return animatedTile(context, index, animation); // Refer step 3
          },
        ),
      ),
    );
  }
}
