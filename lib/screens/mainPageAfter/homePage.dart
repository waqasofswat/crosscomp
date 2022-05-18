import 'package:cross_comp/screens/mainPageAfter/fragments/moreFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/professionalFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/profileFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/scoresFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/teamFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/fragments/volunteerFrag.dart';
import 'package:cross_comp/screens/mainPageAfter/trainings/freeTrainings.dart';

import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:cross_comp/utilities/size_config.dart';
import 'package:flutter/material.dart';

import 'fragments/challengesFrag.dart';
import 'fragments/reservations.dart';

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
    new DrawerItem("Volunteer")
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
    new DrawerItem("Volunteer"),
    new DrawerItem("Professional")
  ];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVol = false;
  bool isProf = false;
  bool isMore = false;
  int _selectedDrawerIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  void initState() {
    super.initState();
    getStates();
    HelperFunction.saveProfShuttleSharedPreference(false);
    HelperFunction.saveProfSquartSharedPreference(false);
    HelperFunction.saveProfLegRaiseSharedPreference(false);
    HelperFunction.saveProfPushUpsSharedPreference(false);
  }

  getStates() async {
    await HelperFunction.getVolSharedPreference().then((value) {
      if (value != null)
        setState(() {
          isVol = value;
          print("isVol  :  $value");
        });
    });

    await HelperFunction.getProfSharedPreference().then((value) {
      if (value != null)
        setState(() {
          isProf = value;
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
        drawerOptions.add(new ListTile(
          title: new Text(
            d.title,
            style: TextStyle(
              fontSize: getProportionateScreenHeight(18),
              fontWeight: FontWeight.w900,
            ),
          ),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        ));
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
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
      //
    );
  }
}
