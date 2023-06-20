import 'package:flutter/material.dart';
class TestHistory{
  int id;
  String username;
  int courseId;
  DateTime testDate;
  double result;
  TestHistory({required this.id,required this.username,required this.courseId,required this.testDate,required this.result});
  static List<TestHistory> init(){
    List<TestHistory> data=[
      TestHistory(id:1,username: "admin",courseId: 1,testDate: DateTime.now(),result: 100 ),
      TestHistory(id:2,username: "admin",courseId: 2,testDate: DateTime.now(),result: 100 ),
      TestHistory(id:3,username: "admin",courseId: 3,testDate: DateTime.now(),result: 100 ),
      TestHistory(id:4,username: "admin",courseId: 4,testDate: DateTime.now(),result: 100 ),
      TestHistory(id:5,username: "admin",courseId: 5,testDate: DateTime.now(),result: 100 ),
    ];
    return data;
  }
}