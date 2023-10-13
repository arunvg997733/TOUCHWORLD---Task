import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapview/controller/location_controller.dart';
import 'package:mapview/core/constant.dart';
import 'package:mapview/view/map_screen/widget.dart';

class Mapscreen extends StatelessWidget {
  Mapscreen({super.key});

  final getLoc = Get.put(LocationController());
  CameraPosition camaraPosition = const CameraPosition(
        target: LatLng(10.527638941814725, 76.21477687419419), zoom: 17);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeadTitleWidget(getLoc: getLoc),
            Expanded(
              child: GoogleMapWidget(
                  camaraPosition: camaraPosition, getLoc: getLoc),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetRouteButtonWidget(getLoc: getLoc),
          width10,
          StartButtonWidget(getLoc: getLoc),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


