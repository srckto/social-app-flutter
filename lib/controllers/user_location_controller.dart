import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserLocationController extends GetxController {
  HashSet<Marker> markers = HashSet<Marker>();
  late LatLng latLng;
  late Set<Circle> circles;

  bool isInitCompleted = false;

  onMapCreated(GoogleMapController _googleMapController) {
    markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: latLng,
        infoWindow: InfoWindow(
          title: "Your Location",
          snippet: "${latLng.latitude} , ${latLng.longitude} ",
          onTap: () => print("No thing important"),
        ),
      ),
    );
    update();
  }

  getLocation() async {
    isInitCompleted = false;
    update();

    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
    circles = Set.from([
      Circle(
        circleId: CircleId("id"),
        center: latLng,
        radius: 400,
        strokeWidth: 0,
        fillColor: Colors.red.withOpacity(0.2),
      )
    ]);

    isInitCompleted = true;
    update();
  }
}





  // Set<Polygon> myPolygon() {
  //   List<LatLng> polygonCoords = [];
  //   polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));
  //   polygonCoords.add(LatLng(37.4300626331129, -122.08832357078792));
  //   polygonCoords.add(LatLng(37.4300626331129, -122.08332357078792));
  //   polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));

  //   Set<Polygon> polygonSet = new Set();
  //   polygonSet.add(
  //     Polygon(
  //       polygonId: PolygonId('test'),
  //       points: polygonCoords,
  //       strokeColor: Colors.red,
  //       fillColor: Colors.black.withOpacity(0.3),
  //       strokeWidth: 4,
  //     ),
  //   );

  //   return polygonSet;
  // }