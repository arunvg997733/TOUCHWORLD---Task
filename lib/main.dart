import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapview/view/map_screen/map_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mapscreen(),
    );
  }
}
