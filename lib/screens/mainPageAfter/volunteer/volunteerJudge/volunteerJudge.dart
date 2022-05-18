import 'dart:async';
import 'dart:convert';

import 'package:cross_comp/screens/mainPageAfter/volunteer/volunteerJudge/volunteerJudgeSchedule.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/volunteerJudge/volunteerJudgeSignUp.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class VolunteerJudge extends StatefulWidget {
  VolunteerJudge({Key? key}) : super(key: key);

  @override
  _VolunteerJudgeState createState() => _VolunteerJudgeState();
}

class _VolunteerJudgeState extends State<VolunteerJudge> {


  static LatLng _initialPosition =
      LatLng(-15.4630239974464, 28.363397732282127);
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition = _initialPosition;
  bool isLoading = true;
  late BitmapDescriptor iconEvent;
  late BitmapDescriptor iconFacility;
  String userId='';
  @override
  void initState() {
    super.initState();

    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
            'assets/images/map_event.png')
        .then((onValue) {
      iconEvent = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
            'assets/images/map_facility.png')
        .then((onValue) {
      iconFacility = onValue;
    });
    _getUserLocation();

    getUserId();
  }

  getUserId() async {

    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null)
        setState(() {

          userId = value;
          print("UserId  :  $value");

          getEventsData();

        });
    });
  }
  List<Map<String, String>> _event = [];
  // List<Map<String, String>> _facility = [];
  Future<Map<String, dynamic>> getEventsData() async {
    print("getEventsData");

    _event.clear();
    String url = mainApiUrl + "?get_all_event_volunteer_judge=true&userID=$userId";

    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      if (response.body.toString().contains("Failure")) {
        print("response Failed");
        setState(() {
          isLoading = false;
        });
      } else {
        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status'] == "failed") {
          setState(() {

            isLoading = false;
          });
        } else {
          try{
            int fXSize= map['sizeX'];
            int fSize= map['size'];

            for(int i=0; i<fSize; i++){
              String id= map['server_response'][i]["Event_ID"].toString();
              bool isManager=false;
              for(int x=0; x<fXSize; x++){
                String idX= map['mngr_response'][x]["Event_ID"].toString();
                if(id==idX)
                  isManager=true;
              }
              String title= map['server_response'][i]["ParkSchoolName"].toString();
              String manager= map['server_response'][i]["Manager"].toString();
              String street= map['server_response'][i]["Street"].toString();
              String city= map['server_response'][i]["City_ID"].toString();
              String state= map['server_response'][i]["State_ID"].toString();
              String day= map['server_response'][i]["Day"].toString();
              String date= map['server_response'][i]["Date"].toString();
              String timing= map['server_response'][i]["hourBlock1"].toString();
              String postalCode= map['server_response'][i]["PostalCode"].toString();
              Map<String, String> mapList={"type": "event","title": title,"id":id,"manager":manager,"street":street,"city":city,"state":state,"postalCode":postalCode,"day":day,"date":date,"timing":timing};

              double lat=double.parse(map['server_response'][i]["lat"].toString()) ;
              double lng=double.parse(map['server_response'][i]["lon"].toString()) ;

              print ("$lat  ::::   $lng");

              if(isManager) {
                _markers.add(Marker(
                    markerId: MarkerId(LatLng(lat, lng).toString()),
                    position: LatLng(lat, lng),
                    infoWindow: InfoWindow(
                        title: title,
                        snippet: "This is an Event",
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VolunteerJudgeSchedule()));
                          // Navigator.of(context).pop();
                        }),
                    onTap: () {},
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)));
              }
              else{
                _markers.add(Marker(
                    markerId: MarkerId(LatLng(lat, lng).toString()),
                    position: LatLng(lat, lng),
                    infoWindow: InfoWindow(
                        title: title,
                        snippet: "This is an Event",
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VolunteerJudgeSignUp(mapList: mapList)));
                          // Navigator.of(context).pop();
                        }),
                    onTap: () {},
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue)));
              }
              setState(() {

                _event.add(mapList);
              });
            }
            //
            // int fSize= map['f_size'];
            // int eSize= map['e_size'];
            // print(eSize);
            // print(fSize);
            //
            // for(int i=0; i<eSize; i++){
            //
            //   String id= map['events'][i]["Event_ID"].toString();
            //
            //   String title= map['events'][i]["ParkSchoolName"].toString();
            //   String manager= map['events'][i]["Manager"].toString();
            //   String street= map['events'][i]["Street"].toString();
            //   String city= map['events'][i]["City_ID"].toString();
            //   String state= map['events'][i]["State_ID"].toString();
            //   String postalCode= map['events'][i]["PostalCode"].toString();
            //   Map<String, String> mapList={"title": title,"id":id,"manager":manager,"street":street,"city":city,"state":state,"postalCode":postalCode};
            //
            //
            //   double lat=double.parse(map['events'][i]["lat"].toString());
            //   double lng=double.parse(map['events'][i]["lon"].toString());
            //   print ("$lat  ::::   $lng");
            //   _markers.add(Marker(
            //       markerId: MarkerId(LatLng(lat, lng).toString()),
            //       position: LatLng(lat, lng),
            //       infoWindow: InfoWindow(
            //           title: title,
            //           snippet: "This is an Event",
            //           onTap: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ProfessionalJudgeSignUp(mapList: mapList)));
            //           }),
            //       onTap: () {},
            //       icon: BitmapDescriptor.defaultMarkerWithHue(
            //           BitmapDescriptor.hueGreen)));
            //   setState(() {
            //
            //     _event.add(mapList);
            //   });
            // }
            // for(int i=0; i<fSize; i++){
            //
            //   String id= map['facilities'][i]["Facility_ID"].toString();
            //   String title= map['facilities'][i]["GymName"].toString();
            //   String manager= map['facilities'][i]["Manager"].toString();
            //   String street= map['facilities'][i]["Street"].toString();
            //   String city= map['facilities'][i]["City_ID"].toString();
            //   String state= map['facilities'][i]["State_ID"].toString();
            //   String postalCode= map['facilities'][i]["PostalCode"].toString();
            //   Map<String, String> mapList={"title": title,"id":id,"manager":manager,"street":street,"city":city,"state":state,"postalCode":postalCode};
            //
            //   double lat=double.parse(map['facilities'][i]["lat"].toString()) ;
            //   double lng=double.parse(map['facilities'][i]["lon"].toString()) ;
            //
            //   print ("$lat  ::::   $lng");
            //
            //
            //   _markers.add(Marker(
            //       markerId: MarkerId(LatLng(lat,lng).toString()),
            //       position: LatLng(lat,lng),
            //       infoWindow: InfoWindow(
            //           title: title,
            //           snippet: "This is a facility",
            //           onTap: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => ProfessionalJudgeSignUp(mapList: mapList)));
            //           }),
            //       onTap: () {},
            //       icon: BitmapDescriptor.defaultMarkerWithHue(
            //           BitmapDescriptor.hueBlue)));
            //   setState(() {
            //
            //     _facility.add(mapList);
            //   });
            // }
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
      setState(() {
        print(
            '_getUserLocation : setstate ${position.latitude} ${position.longitude}');
        _initialPosition = LatLng(position.latitude, position.longitude);
        _lastMapPosition = LatLng(position.latitude, position.longitude);
        print('${placemark[0].name}');
        isLoading = false;

        // _markers.add(Marker(
        //     markerId: MarkerId(LatLng(35.140929, 72.527667).toString()),
        //     position: LatLng(35.140929, 72.527667),
        //     infoWindow: InfoWindow(
        //         title: "Brecken Park",
        //         snippet: "This is a snippet",
        //         onTap: () {
        //           // Navigator.push(
        //           //     context,
        //           //     MaterialPageRoute(
        //           //         builder: (context) => ProfessionalJudgeSignUp()));
        //         }),
        //     onTap: () {},
        //     icon: BitmapDescriptor.defaultMarkerWithHue(
        //         BitmapDescriptor.hueBlue)));
        //
        // _markers.add(Marker(
        //     markerId: MarkerId(LatLng(35.146132, 72.536347).toString()),
        //     position: LatLng(35.146132, 72.536347),
        //     infoWindow: InfoWindow(
        //         title: "BreckenFit Park",
        //         snippet: "This is a snippet",
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => VolunteerJudgeSignUp()));
        //         }),
        //     onTap: () {},
        //     icon: BitmapDescriptor.defaultMarkerWithHue(
        //         BitmapDescriptor.hueGreen)));
      });
    } catch (e) {
      print('_getUserLocation : error : $e');
      print(e);
    }
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {

    });
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      // _markers.add(Marker(
      //     markerId: MarkerId(_lastMapPosition.toString()),
      //     position: _lastMapPosition,
      //     infoWindow: InfoWindow(
      //         title: "BreckenFit Gym",
      //         snippet: "This is a snippet",
      //         onTap: () {}),
      //     onTap: () {},
      //     icon: BitmapDescriptor.defaultMarker));
    });
  }

  Widget mapButton(Function() function, Icon icon, Color color) {
    return RawMaterialButton(
      onPressed: function,
      child: icon,
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(7.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(
                child: Text(
                  'loading map..',
                  style: TextStyle(
                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                ),
              ),
            )
          : Container(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    onTap: (lt) async {

                    },
                    markers: _markers,
                    mapType: _currentMapType,
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14.4746,
                    ),
                    onMapCreated: _onMapCreated,
                    zoomGesturesEnabled: true,
                    onCameraMove: _onCameraMove,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    myLocationButtonEnabled: false,
                  ),

                ],
              ),
            ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<LatLng>('_initialPosition', _initialPosition));
  }
}
