import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapview/controller/location_controller.dart';
import 'package:mapview/core/constant.dart';
import 'package:mapview/view/map_screen/widget.dart';

class Mapscreen extends StatelessWidget {
  Mapscreen({super.key});

  final getLoc = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _completer = Completer();
    CameraPosition camaraPosition = CameraPosition(
        target: LatLng(10.527638941814725, 76.21477687419419), zoom: 20);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Center(
                      child:
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Center(child: textStyleWidget(getLoc.text.toString(), 25, kWhite))),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    getLoc.clear();
                                  },
                                  child: Center(child: textStyleWidget('Clear',20,kRed))))
                            ],
                          )
                          )
                          ),
            ),
            Expanded(child: GoogleMapWidget(camaraPosition: camaraPosition, getLoc: getLoc)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: textStyleWidget('Get Route', 15, kWhite),
        onPressed: () {
          getLoc.getPolylinePoint();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


