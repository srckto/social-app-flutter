import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_app/controllers/user_location_controller.dart';

class UserLocationScreen extends StatelessWidget {
  UserLocationScreen({Key? key}) : super(key: key);

  final UserLocationController _userLocationController = Get.put(UserLocationController());

  @override
  Widget build(BuildContext context) {
    _userLocationController.getLocation();
    return GetBuilder<UserLocationController>(
      builder: (_) => !_userLocationController.isInitCompleted
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                // bearing: 192.8334901395799,
                target: _userLocationController.latLng,
                // tilt: 59.440717697143555,
                zoom: 16,
              ),
              onMapCreated: _userLocationController.onMapCreated,
              markers: _userLocationController.markers,
              circles: _userLocationController.circles,
            ),
    );
  }
}
