import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learningcodeapp/model/testhistory.dart';
import 'package:flutter/material.dart';
import 'package:learningcodeapp/model/ultilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CourseHistorySection extends StatelessWidget {
  late Future<List<TestHistory>> testHistoryAPI = Ultilities().getTestHistory();
  var prefs;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<TestHistory> testHistory= TestHistory.init();
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width:  MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide.none),
              color: Color.fromRGBO(41, 96, 86, 1.0),
              child: Text("   Course history",style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
            FutureBuilder(
                future: testHistoryAPI,
                builder: (context,snapshot){
                  if(snapshot.hasData)
                    return Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide.none),
                      color: Color.fromRGBO(255, 255, 255, 0.75),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Table(
                            children: [
                              TableRow(
                                decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide.none),color: Color.fromRGBO(41, 96, 86, 1.0)),
                                children: [
                                  Center(child:Text("Course Name",style: TextStyle(fontSize: 18,color: Colors.white))),
                                  Center(child:Text("Score",style: TextStyle(fontSize: 18,color: Colors.white))),
                                  Center(child:Text("Date",style: TextStyle(fontSize: 18,color: Colors.white))),
                                ],
                              ),
                              for(var item in snapshot.data!)
                                TableRow(
                                  children: [
                                    Center(child: Text(item.courseId.toString())),
                                    Center(child:Text(item.result.toString())),
                                    Center(child:Text(item.testDate.day.toString()+"/"+item.testDate.month.toString()+"/"+item.testDate.year.toString())),
                                  ],
                                )
                            ],
                          )
                      ),
                    );
                  else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }
            )

          ],
        ),
      ),
    );
  }
}