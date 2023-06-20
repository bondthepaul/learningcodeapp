import 'package:flutter/material.dart';
import 'package:learningcodeapp/signup/components/Body.dart';
class SignUpPage extends StatelessWidget{
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}