import 'dart:async';
import 'dart:convert';
import 'package:cross_comp/screens/mainPageAfter/trainings/freeTrainingEventFacility.dart';
import 'package:cross_comp/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class FreeTrainings extends StatefulWidget {
  FreeTrainings({Key? key}) : super(key: key);

  @override
  _FreeTrainingsState createState() => _FreeTrainingsState();
}

class _FreeTrainingsState extends State<FreeTrainings> {


  static LatLng _initialPosition =
      LatLng(-15.4630239974464, 28.363397732282127);
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition = _initialPosition;
  bool isLoaded = true;
  late BitmapDescriptor iconEvent;
  late BitmapDescriptor iconFacility;

  @override
  void initState() {
    super.initState();
    getEventsFacilitiesData();
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
  }

  List<Map<String, String>> _event = [];
  List<Map<String, String>> _facility = [];
  Future<Map<String, dynamic>> getEventsFacilitiesData() async {
    print("getEventsFacilitiesData Free Trainings");

    _event.clear();
    _facility.clear();
    String url = mainApiUrl + "?get_facility_event=true&isFree=1";

    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      if (response.body.toString().contains("Failure")) {
        print("response Failed");
        setState(() {
          isLoaded = false;
        });
      } else {
        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status'] == "failed") {
          setState(() {

            isLoaded = false;
          });
        } else {
          try{


            int fSize= map['f_size'];
            int eSize= map['e_size'];
            print(eSize);
            print(fSize);

            for(int i=0; i<eSize; i++){

              String id= map['events'][i]["Event_ID"].toString();

              String title= map['events'][i]["ParkSchoolName"].toString();
              String manager= map['events'][i]["Manager"].toString();
              String street= map['events'][i]["Street"].toString();
              String city= map['events'][i]["City_ID"].toString();
              String state= map['events'][i]["State_ID"].toString();
              String postalCode= map['events'][i]["PostalCode"].toString();
              Map<String, String> mapList={"title": title,"id":id,"manager":manager,"street":street,"city":city,"state":state,"postalCode":postalCode};


              double lat=double.parse(map['events'][i]["lat"].toString());
              double lng=double.parse(map['events'][i]["lon"].toString());
              print ("$lat  ::::   $lng");


              _markers.add(Marker(
                  markerId: MarkerId(LatLng(lat, lng).toString()),
                  position: LatLng(lat, lng),
                  infoWindow: InfoWindow(
                      title: title,
                      snippet: "This is an Event free training",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreeTrainingEventsFacilities(isEvent: true,isFacility: false,id: id,)));

                      }),
                  onTap: () {},
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen)));
              setState(() {

                _event.add(mapList);
              });
            }
            for(int i=0; i<fSize; i++){

              String id= map['facilities'][i]["Facility_ID"].toString();
              String title= map['facilities'][i]["GymName"].toString();
              String manager= map['facilities'][i]["Manager"].toString();
              String street= map['facilities'][i]["Street"].toString();
              String city= map['facilities'][i]["City_ID"].toString();
              String state= map['facilities'][i]["State_ID"].toString();
              String postalCode= map['facilities'][i]["PostalCode"].toString();
              Map<String, String> mapList={"title": title,"id":id,"manager":manager,"street":street,"city":city,"state":state,"postalCode":postalCode};

              double lat=double.parse(map['facilities'][i]["lat"].toString()) ;
              double lng=double.parse(map['facilities'][i]["lon"].toString()) ;

              print ("$lat  ::::   $lng");


              _markers.add(Marker(
                  markerId: MarkerId(LatLng(lat, lng).toString()),
                  position: LatLng(lat, lng),
                  infoWindow: InfoWindow(
                      title: title,
                      snippet: "This is a free training",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FreeTrainingEventsFacilities(isEvent: false,isFacility: true,id: id,)));
                      }),
                  onTap: () {},
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue)));
              setState(() {

                _facility.add(mapList);
              });
            }
          }catch(e){
            print(e.toString());

          }
          setState(() {
            isLoaded = false;
          });
        }

        print("response Success");


      }
      return json.decode(response.body.toString());
    } else {
      setState(() {
        isLoaded = false;
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
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
              title: "BreckenFit Gym",
              snippet: "This is a free training",
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
      body: isLoaded
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
