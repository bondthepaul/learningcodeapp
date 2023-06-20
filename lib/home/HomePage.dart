import 'package:flutter/material.dart';
import 'package:learningcodeapp/home/components/Body.dart';
class HomePage extends StatelessWidget{
  static String routeName = "/home";
  int selectIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}