import 'dart:convert';

import 'package:cross_comp/component/loading.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/moreFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/professionalFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/profileFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/scoresFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/teamFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/volunteerFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/professionals/profStatusPendingPage.dart';
import 'package:cross_comp/screens/mainPageAfter/trainings/freeTrainings.dart';

import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'fragments/challengesFrag.dart';
import 'fragments/reservations.dart';
import 'package:http/http.dart' as http;
class DrawerItem {
  String title;
  DrawerItem(this.title);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Reservation"),
    new DrawerItem("Scores"),
    new DrawerItem("Teams"),
    new DrawerItem("Challenges"),
    new DrawerItem("Exercise Rx"),
    new DrawerItem("Training"),
    new DrawerItem("Profile"),
    new DrawerItem("More")
  ];
  final drawerItemsVol = [
    new DrawerItem("Reservation"),
    new DrawerItem("Scores"),
    new DrawerItem("Teams"),
    new DrawerItem("Challenges"),
    new DrawerItem("Exercise Rx"),
    new DrawerItem("Training"),
    new DrawerItem("Profile"),
    new DrawerItem("More"),
    new DrawerItem("Volunteer Menu")
  ];
  final drawerItemsProf = [
    new DrawerItem("Reservation"),
    new DrawerItem("Scores"),
    new DrawerItem("Teams"),
    new DrawerItem("Challenges"),
    new DrawerItem("Exercise Rx"),
    new DrawerItem("Training"),
    new DrawerItem("Profile"),
    new DrawerItem("More"),
    new DrawerItem("Volunteer Menu"),
    new DrawerItem("Professional")
  ];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  bool isVol = false;
  bool isProf = false;
  bool isMore = false;
  int _selectedDrawerIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getUserData();
    });

    HelperFunction.saveProfShuttleSharedPreference(false);
    HelperFunction.saveProfSquartSharedPreference(false);
    HelperFunction.saveProfLegRaiseSharedPreference(false);
    HelperFunction.saveProfPushUpsSharedPreference(false);
  }

  getStates() async {
    await HelperFunction.getUserTypeSharedPreference().then((value) {
      if (value != null)
        setState(() {
          if(value.toLowerCase().contains("professional")){
            isVol=true;
            isProf=true;
            HelperFunction.saveVolSharedPreference(true);
            HelperFunction.saveProfSharedPreference(true);
          }else if(value.toLowerCase().contains("volunteer")){
            isVol=true;
            isProf=false;
            HelperFunction.saveVolSharedPreference(true);
            HelperFunction.saveProfSharedPreference(false);

          }else{
            isProf=false;
            isVol=false;
            HelperFunction.saveProfSharedPreference(false);
            HelperFunction.saveVolSharedPreference(false);
          }
          print("isVol  :  $value");
        });
    });

    await HelperFunction.getProfSharedPreference().then((value) {
      if (value != null)
        setState(() {
        //  isProf = value;
          print("isProf  :  $value");
        });
    });
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new ReservationFrag();
      case 1:
        return new ScoresFrag();
      case 2:
        return new TeamFrag();
      case 3:
        return new MyChallenges();

      case 5:
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => FreeTrainings()));
        return new FreeTrainings();

      case 6:
        return new ProfileFrag();
      case 7:
        return new MoreFrag();
      case 8:
        return new VolunteerFrag();
      case 9:
        return new ProfessionalFrag();

      default:
        return Center(child: new Text("Coming Soon"));
    }
  }

  _onSelectItem(int index) {
    if (!isMore) Navigator.of(context).pop();
    setState(() {
      _selectedDrawerIndex = index;
      if (index == 7) isMore = true;
    });
// close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    if (isProf) {
      for (var i = 0; i < widget.drawerItemsProf.length; i++) {
        var d = widget.drawerItemsProf[i];

          drawerOptions.add(
              ListTile(
                title: new Text(
                  d.title,
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(18),
                    fontWeight: FontWeight.w900,
                    color: d.title.contains("More")?kGreenColor:kPrimaryColor,
                  ),
                ),
                selected: i == _selectedDrawerIndex,
                onTap: () => _onSelectItem(i),
              )
          );




      }
    } else if (isVol) {
      for (var i = 0; i < widget.drawerItemsVol.length; i++) {
        var d = widget.drawerItemsVol[i];

          drawerOptions.add(new ListTile(
            title: new Text(
              d.title,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(18),
                fontWeight: FontWeight.w900,
                color: d.title.contains("More") ? kGreenColor : kPrimaryColor,

              ),
            ),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          ));

      }
    } else {
      for (var i = 0; i < widget.drawerItems.length; i++) {
        var d = widget.drawerItems[i];

          drawerOptions.add(ListTile(
            title: Text(
              d.title,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(18),
                fontWeight: FontWeight.w900,
                color: d.title.contains("More") ? kGreenColor : kPrimaryColor,

              ),
            ),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          ));

      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: kPrimaryColor,
          title: Text(
            _selectedDrawerIndex == 3
                ? "My Challenges"
                : widget.drawerItemsProf[_selectedDrawerIndex].title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
              icon: isMore ? Icon(Icons.arrow_back) : Icon(Icons.dehaze),
              onPressed: () {
                if (isMore) {
                  _onSelectItem(0);
                  isMore = false;
                } else {
                  if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                    _scaffoldKey.currentState!.openDrawer();
                  } else {
                    _scaffoldKey.currentState!.openEndDrawer();
                  }
                }
              })),

      body: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(children: drawerOptions),
        ),
        body:  isLoading
          ? Center(child: Loading())
            : _getDrawerItemWidget(_selectedDrawerIndex),
      ),
      //
    );
  }

  Future<Map<String, dynamic>> getUserData() async {
    setState(() {
      isLoading = true;

    });

   String? email= await HelperFunction.getUserEmailSharedPreference();
   String? password= await HelperFunction.getUserPassSharedPreference();
    String url = mainApiUrl +
        "?login_user=true&login_email=${email}&login_pass=${password}";

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
            password= "";
          });
        } else {
          print(map["server_response"][0]["First_Name"]);

          HelperFunction.saveUserIdSharedPreference(
              "${map["server_response"][0]["User_ID"]}");

          HelperFunction.saveUserNameSharedPreference(
              "${map["server_response"][0]["First_Name"]} ${map["server_response"][0]["Last_Name"]}");

          HelperFunction.saveUserTypeSharedPreference( "${map["server_response"][0]["User_Type"]}");
          getStates();
          // _btnController.success();
          // progress?.dismiss();
          isLoading = false;
          //getLogin();
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
}
