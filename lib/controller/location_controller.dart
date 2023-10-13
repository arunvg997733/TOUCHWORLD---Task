import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapview/core/apikey.dart';
import 'package:mapview/view/map_screen/widget.dart';

class LocationController extends GetxController {
  List<LatLng> polylinePointerList = [];
  LatLng startPoint = const LatLng(0, 0);
  LatLng endPoint = const LatLng(0, 0);
  RxString text = 'Select Start Point by tap'.obs;
  Marker marker = const Marker(markerId: MarkerId('3'));
  BitmapDescriptor carIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor startIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor endIcon = BitmapDescriptor.defaultMarker;

  getStartPoint(LatLng position) {
    startPoint = position;
    text.value = 'Select End Point by tap';
    update();
  }

  getEndPoint(LatLng position) {
    endPoint = position;
    text.value = 'Click on Get Route';
    update();
  }

  getPolylinePoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(startPoint.latitude, startPoint.longitude),
        PointLatLng(endPoint.latitude, endPoint.longitude),
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((element) {
          polylinePointerList.add(
            LatLng(element.latitude, element.longitude),
          );
        });
      }
    } catch (e) {
      showSnacksBar("Error", e.toString());
    }
    update();
  }

  clear() {
    polylinePointerList = [];
    startPoint = const LatLng(0, 0);
    endPoint = const LatLng(0, 0);
    text.value = 'Select Start Point by tap';
    update();
  }

  void animatedCarMoving() async {
    for (double i = 0.0; i < 1.0; i += 0.01) {
      LatLng newPosition = LatLng(
        startPoint.latitude + i * (endPoint.latitude - startPoint.latitude),
        startPoint.longitude + i * (endPoint.longitude - startPoint.longitude),
      );
      marker = marker.copyWith(positionParam: newPosition);
      update();
      
      await Future.delayed(
        const Duration(milliseconds: 25),
      );
    }
  }

  getCarIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'asset/Car.png')
        .then((value) => carIcon = value);
  }

  getStartIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'asset/Start.png')
        .then((value) => startIcon = value);
  }

  getEndIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'asset/End.png')
        .then((value) => endIcon = value);
  }
}
