import 'package:flutter/material.dart';

const kWhite = Colors.white;
const kBlack = Colors.black;
const kBlue = Colors.blue;
const kRed = Colors.red;


Widget textStyleWidget(String text,double size,Color color){
  return Text(text,style: TextStyle(fontSize: size,color: color),);
}