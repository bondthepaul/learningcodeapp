import 'package:flutter/material.dart';
class User{
  int userId;
  String username;
  String password;
  int HighScore;
  int finishCourses	;
  double average;
  var image;
  User({required this.userId,required this.username,required this.password,required this.HighScore,required this.finishCourses,required this.average,required this.image});
}