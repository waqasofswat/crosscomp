import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FreeFacilityTrainingNavigation extends StatefulWidget {
  FreeFacilityTrainingNavigation({Key? key}) : super(key: key);

  @override
  _FreeFacilityTrainingNavigationState createState() =>
      _FreeFacilityTrainingNavigationState();
}

class _FreeFacilityTrainingNavigationState
    extends State<FreeFacilityTrainingNavigation> {

  final Set<Polyline> polyline = {};
  late List<LatLng> routeCoords;
  // GoogleMapPolyline
  double _originLatitude = 35.170929, _originLongitude = 72.531987;
  double _destLatitude = 35.12132, _destLongitude = 72.523497;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDfzZIAt3V2ck7R46NJ3BsbJHpPFPt2rZ0";

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

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
    _getUserLocation();
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);

    setState(() {
      polylines[id] = polyline;
    });
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      print("Not Empty");
    } else {
      print("Empty");
    }
    _addPolyLine();
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
        isLoaded = false;

        _markers.add(Marker(
            markerId: MarkerId(LatLng(35.140929, 72.527667).toString()),
            position: LatLng(35.140929, 72.527667),
            infoWindow: InfoWindow(
                title: "BreckenFit Park",
                snippet: "This is a snippet",
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ProfessionalJudgeSignUp()));
                }),
            onTap: () {},
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue)));

        _markers.add(Marker(
            markerId: MarkerId(LatLng(35.146132, 72.536347).toString()),
            position: LatLng(35.146132, 72.536347),
            infoWindow: InfoWindow(
                title: "BreckenFit Park",
                snippet: "This is a snippet",
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ProfessionalJudgeSignUp()));
                }),
            onTap: () {},
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen)));
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
                      // setState(() {
                      //   _markers.add(Marker(
                      //       markerId: MarkerId(lt.toString()),
                      //       position: lt,
                      //       infoWindow: InfoWindow(
                      //           title: "Tap Marker",
                      //           snippet: "This is a snippet",
                      //           onTap: () {}),
                      //       onTap: () {},
                      //       icon: BitmapDescriptor.defaultMarker));
                      // });
                    },
                    // markers: _markers,
                    markers: Set<Marker>.of(markers.values),
                    mapType: _currentMapType,
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14.4746,
                    ),
                    onMapCreated: _onMapCreated,
                    tiltGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    onCameraMove: _onCameraMove,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    myLocationButtonEnabled: false,
                    polylines: Set<Polyline>.of(polylines.values),
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
