import 'dart:async';
import 'dart:convert';

import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/assistantTrainerSchedule.dart';
import 'package:cross_comp/screens/mainPageAfter/volunteer/assistantTrainers/assistantTrainerSignUp.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:cross_comp/utilities/helperFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AssistantTrainers extends StatefulWidget {
  AssistantTrainers({Key? key}) : super(key: key);

  @override
  _AssistantTrainersState createState() => _AssistantTrainersState();
}

class _AssistantTrainersState extends State<AssistantTrainers> {


  static LatLng _initialPosition =
      LatLng(-15.4630239974464, 28.363397732282127);
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition = _initialPosition;
  String userId='';
  bool isLoading = true;
  late BitmapDescriptor iconEvent;
  late BitmapDescriptor iconFacility;

  @override
  void initState() {
    super.initState();


    _getUserLocation();

    getUserId();
  }
  getUserId() async {

    await HelperFunction.getUserIdSharedPreference().then((value) {
      if (value != null)
        setState(() {

          userId = value;
          print("UserId  :  $value");

          getEventsFacilitiesData();

        });
    });
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
      });
    } catch (e) {
      print('_getUserLocation : error : $e');
      print(e);
    }
  }

  List<Map<String, String>> _event = [];
  List<Map<String, String>> _facility = [];
  Future<Map<String, dynamic>> getEventsFacilitiesData() async {
    print("saveEventData");

    _event.clear();
    String url = mainApiUrl + "?get_facility_event=true&isFree=1&userID=$userId";

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


            int fSize= map['f_size'];
            int eSize= map['e_size'];

            int fXSize= map['sizeX'];
            print(eSize);
            print(fSize);

            for(int i=0; i<eSize; i++){

              String id= map['events'][i]["Event_ID"].toString();
              bool isManager=false;
              for(int x=0; x<fXSize; x++){
                print(map['mngr_response'][x].toString());
                String idX= map['mngr_response'][x]["ef_id"].toString();
                if(id==idX)
                  isManager=true;
              }
              String title= map['events'][i]["ParkSchoolName"].toString();
              String manager= map['events'][i]["Manager"].toString();
              String street= map['events'][i]["Street"].toString();
              String city= map['events'][i]["City_ID"].toString();
              String state= map['events'][i]["State_ID"].toString();
              String postalCode= map['events'][i]["PostalCode"].toString();
              String day= map['events'][i]["Day"].toString();
              String date= map['events'][i]["Date"].toString();
              String timing= map['events'][i]["hourBlock1"].toString();

              Map<String, String> mapList={"type": "event","title": title,"id":id,"manager":manager,"street":street,"city":city,"state":state,"postalCode":postalCode,"day":day,"date":date,"timing":timing};


              double lat=double.parse(map['events'][i]["lat"].toString());
              double lng=double.parse(map['events'][i]["lon"].toString());
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
                                      AssistantTrainerSchedule()));
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
                                      AssistantTrainerSignUp(mapList: mapList)));
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

            DateTime dateX = DateTime.now();
            for(int i=0; i<fSize; i++){

              String id= map['facilities'][i]["Facility_ID"].toString();
              bool isManager=false;
              for(int x=0; x<fXSize; x++){

                print(map['mngr_response'][x].toString());
                String idX= map['mngr_response'][x]["ef_id"].toString();
                if(id==idX)
                  isManager=true;

              }
              String currDate = dateX.day.toString() +
                  "/" +
                  (dateX.month + 1).toString() +
                  "/" +
                  dateX.year.toString();
              String day = "Monday";
              for (int i = 0; i < 7; i++) {
                DateTime dateZ = dateX.add(Duration(days: i));

                String currDay = DateFormat('EEEE').format(dateZ);
                print("Current Day : " + currDay);
                print(" Day : " + day);
                if (currDay == day) {
                  currDate = dateZ.month.toString() +
                      "/" +
                      dateZ.day.toString() +
                      "/" +
                      dateZ.year.toString();
                  print("$day  -------  $currDay");
                }
                print("-------------------");
              }

              String title= map['facilities'][i]["GymName"].toString();
              String manager= map['facilities'][i]["Manager"].toString();
              String street= map['facilities'][i]["Street"].toString();
              String city= map['facilities'][i]["City_ID"].toString();
              String state= map['facilities'][i]["State_ID"].toString();
              String postalCode= map['facilities'][i]["PostalCode"].toString();
              String timing= map['facilities'][i]["monday_HB"].toString();

              Map<String, String> mapList={"type": "facility","title": title,"id":id,"manager":manager,"street":street,"city":city,"state":state,"postalCode":postalCode,"day":day,"date":currDate,"timing":timing};


              double lat=double.parse(map['facilities'][i]["lat"].toString()) ;
              double lng=double.parse(map['facilities'][i]["lon"].toString()) ;

              print ("$lat  ::::   $lng");

              if(isManager){

                _markers.add(Marker(
                    markerId: MarkerId(LatLng(lat,lng).toString()),
                    position: LatLng(lat,lng),
                    infoWindow: InfoWindow(
                        title: title,
                        snippet: "This is a facility",
                        onTap: () {

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AssistantTrainerSchedule()));

                          // Navigator.of(context).pop();
                        }),
                    onTap: () {},
                    icon:BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)));

              }
              else{


                _markers.add(Marker(
                    markerId: MarkerId(LatLng(lat,lng).toString()),
                    position: LatLng(lat,lng),
                    infoWindow: InfoWindow(
                        title: title,
                        snippet: "This is a facility",
                        onTap: () {

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AssistantTrainerSignUp(mapList: mapList)));

                          // Navigator.of(context).pop();
                        }),
                    onTap: () {},
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue)));


              }
              setState(() {

                _facility.add(mapList);
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
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
              title: "BreckenFit Gym",
              snippet: "This is a snippet",
              onTap: () {}),
          onTap: () {},
          icon: BitmapDescriptor.defaultMarker));
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
