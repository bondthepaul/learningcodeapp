import 'package:flutter/material.dart';
import 'package:learningcodeapp/signin/components/Body.dart';
class SignInPage extends StatelessWidget{
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Body(),
    );
  }
}