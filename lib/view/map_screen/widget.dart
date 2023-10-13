import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapview/controller/location_controller.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    super.key,
    required this.camaraPosition,
    required this.getLoc,
  });

  final CameraPosition camaraPosition;
  final LocationController getLoc;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (controller) {
        return GoogleMap(
          initialCameraPosition: camaraPosition,
          markers: {
            Marker(
              markerId: MarkerId('1'),
              position: LatLng(controller.startPoint.latitude,
                  controller.startPoint.longitude),
            ),
            Marker(
                markerId: MarkerId('2'),
                position: LatLng(controller.endPoint.latitude,
                    controller.endPoint.longitude))
          },
          polylines: {
            Polyline(
                polylineId: PolylineId('1'),
                points: getLoc.polylinePointerList,
                color: Colors.blue,
                width: 5)
          },
          onTap: (argument) {
            if (getLoc.startPoint.latitude == 0) {
              getLoc.getStartPoint(argument);
            } else if (getLoc.endPoint.latitude == 0) {
              getLoc.getEndPoint(argument);
            }
          },
        );
      },
    );
  }
}