import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapview/controller/location_controller.dart';
import 'package:mapview/core/constant.dart';

Widget textStyleWidget(String text, double size, Color color) {
  return Text(
    text,
    style: TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold),
    overflow: TextOverflow.ellipsis,
  );
}

class HeadTitleWidget extends StatelessWidget {
  const HeadTitleWidget({
    super.key,
    required this.getLoc,
  });

  final LocationController getLoc;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 65,
        width: double.infinity,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Center(
                    child: textStyleWidget(getLoc.text.toString(), 25, kWhite),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      getLoc.clear();
                    },
                    child: Center(
                      child: textStyleWidget('Clear', 25, kRed),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
                markerId: const MarkerId('1'),
                position: LatLng(controller.startPoint.latitude,
                    controller.startPoint.longitude),
                icon: getLoc.startIcon),
            Marker(
                markerId: const MarkerId('2'),
                position: LatLng(controller.endPoint.latitude,
                    controller.endPoint.longitude),
                icon: getLoc.endIcon),
            getLoc.marker.copyWith(
                onTapParam: () {
                  showBottonSheetWidget(context);
                },
                iconParam: getLoc.carIcon)
          },
          polylines: {
            Polyline(
                polylineId: const PolylineId('1'),
                points: getLoc.polylinePointerList,
                color: Colors.blue,
                width: 10)
          },
          onTap: (argument) {
            if (getLoc.startPoint.latitude == 0) {
              getLoc.getStartIcon();
              getLoc.getStartPoint(argument);
            } else if (getLoc.endPoint.latitude == 0) {
              getLoc.getEndIcon();
              getLoc.getEndPoint(argument);
            }
          },
        );
      },
    );
  }
}

showBottonSheetWidget(BuildContext context) {
  final size = MediaQuery.of(context).size.height;
  showBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: size * .5,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [kWhite, kWhite, kBlue]),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              height10,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textStyleWidget('Driver', 20, kBlack),
                        height10,
                        textStyleWidget('Vehicle Number', 20, kBlack),
                        height10,
                        textStyleWidget('Vehicle Model', 20, kBlack),
                        height10,
                        textStyleWidget('Seat Capacity', 20, kBlack),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      textStyleWidget(':  ', 20, kBlack),
                      height10,
                      textStyleWidget(':  ', 20, kBlack),
                      height10,
                      textStyleWidget(':  ', 20, kBlack),
                      height10,
                      textStyleWidget(':  ', 20, kBlack),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textStyleWidget('Arun V G', 20, kBlack),
                        height10,
                        textStyleWidget('KL 08 BL 1234', 20, kBlack),
                        height10,
                        textStyleWidget('Sedan', 20, kBlack),
                        height10,
                        textStyleWidget('4', 20, kBlack),
                      ],
                    ),
                  )
                ],
              ),
              height10,
              Container(
                height: size * .2,
                width: size * .2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/Car.png'),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

class StartButtonWidget extends StatelessWidget {
  const StartButtonWidget({
    super.key,
    required this.getLoc,
  });

  final LocationController getLoc;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: textStyleWidget('Start', 15, kWhite),
      onPressed: () {
        if (getLoc.startPoint.latitude == 0 || getLoc.endPoint.latitude == 0) {
          Get.snackbar(
            "Warning",
            "Select Start and End Points",
            backgroundColor: kRed,
            colorText: kWhite,
          );
        } else {
          getLoc.getCarIcon();
          getLoc.animatedCarMoving();
        }
      },
    );
  }
}

class GetRouteButtonWidget extends StatelessWidget {
  const GetRouteButtonWidget({
    super.key,
    required this.getLoc,
  });

  final LocationController getLoc;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: textStyleWidget('Get Route', 15, kWhite),
      onPressed: () {
        if (getLoc.startPoint.latitude == 0 || getLoc.endPoint.latitude == 0) {
          showSnacksBar(
            "Warning",
            "Select Start and End Points",
          );
        } else {
          getLoc.getPolylinePoint();
        }
      },
    );
  }
}

showSnacksBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    backgroundColor: kRed,
    colorText: kWhite,
  );
}
