import 'package:learningcodeapp/home/components/fragments/section/status/UserPreviewSection.dart';
import 'package:learningcodeapp/home/components/fragments/section/status/CourseHistorySection.dart';
import 'package:flutter/material.dart';
class StatusPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.92,
      child: ListView(
      children: [
          UserPreview(),
          CourseHistorySection()
      ],
    ),
    );
  }
}