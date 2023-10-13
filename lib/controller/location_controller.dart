import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapview/core/apikey.dart';

class LocationController extends GetxController {
  List<LatLng> polylinePointerList = [];
  LatLng startPoint = const LatLng(0, 0);
  LatLng endPoint = const LatLng(0, 0);
  RxString text = 'Select Start Point by tap'.obs;
  RxString text2 = 'Get Route'.obs;

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
    text2.value = 'Clear';
    print('Start');
    PolylinePoints polylinePoints = PolylinePoints();

    try {
      PolylineResult _result = await polylinePoints.getRouteBetweenCoordinates(
          apiKey,
          PointLatLng(startPoint.latitude, startPoint.longitude),
          PointLatLng(endPoint.latitude, endPoint.longitude));
      if (_result.points.isNotEmpty) {
        _result.points.forEach((element) {
          polylinePointerList.add(LatLng(element.latitude, element.longitude));
        });
      } else {
        print('empty');
      }
    } catch (e) {
      print("Arun $e");
    }
    update();
  }

  clear(){
   polylinePointerList = [];
   startPoint = const LatLng(0, 0);
   endPoint = const LatLng(0, 0);
   text.value = 'Select Start Point by tap';
    update();
  }

  //http//
// getroute()async{

//   final response =await Dio(BaseOptions()).get('https://maps.googleapis.com/maps/api/directions/json',queryParameters: {
//     'origin':'10.527638941814725, 76.21477687419419',
//     'destination':'10.30667011234486, 76.33422921210598',
//     'key':'AIzaSyC62522V8c1EpIhl4DisiYm8Lh6C2q2Now'
//   });

//   print(response.statusCode);
//   if(response.statusCode == 200){
//     final data =await jsonDecode(response.data);
//     print(data.toString());
//   }

// }
}
