import 'package:learningcodeapp/game/GamePage.dart';
import 'package:learningcodeapp/home/HomePage.dart';
import 'package:learningcodeapp/signin/SignInPage.dart';
import 'package:learningcodeapp/splash/ScorePage.dart';
import 'package:learningcodeapp/splash/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:learningcodeapp/model/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignInPage.routeName,
      routes: routes,
    );
  }

}