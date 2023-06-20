
import 'package:learningcodeapp/course/CoursePage.dart';
import 'package:learningcodeapp/game/GamePage.dart';
import 'package:learningcodeapp/home/HomePage.dart';
import 'package:learningcodeapp/signin/SignInPage.dart';
import 'package:learningcodeapp/signup/SignUpPage.dart';
import 'package:learningcodeapp/splash/SplashPage.dart';
import 'package:learningcodeapp/splash/ScorePage.dart';
import 'package:flutter/widgets.dart';


final Map<String, WidgetBuilder> routes ={
  SplashPage.routeName:(context)=>SplashPage(),
  SignInPage.routeName:(context)=>SignInPage(),
  SignUpPage.routeName:(context)=>SignUpPage(),
  HomePage.routeName:(context)=>HomePage(),
  CoursePage.routeName:(context)=>CoursePage(),
  ScorePage.routeName:(context)=>ScorePage(),
  GamePage.routeName:(context)=>GamePage(),
  //StatusPage.routeName:(context)=>StatusPage(),
};