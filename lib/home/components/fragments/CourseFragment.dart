import 'package:learningcodeapp/home/components/fragments/section/course/ListCourseSection.dart';
import 'package:learningcodeapp/home/components/fragments/section/course/SearchSession.dart';
import 'package:flutter/material.dart';
class CoursePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height*0.934,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SeachHeader(),
          ListCourseSection(),
        ],
      ),
    );
  }
}