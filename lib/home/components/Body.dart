import 'package:learningcodeapp/home/components/fragments/CourseFragment.dart';
import 'package:learningcodeapp/home/components/fragments/StatusFragment.dart';
import 'package:learningcodeapp/home/components/fragments/AccountFragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class Body extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<Body>{
  var seletedIndex = 0;
  List<Widget> screen = [
    StatusPage(),
    CoursePage(),
    AccountFragment(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: seletedIndex,
        onTap: (index){
         setState(() {
           seletedIndex = index;
         });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(1, 1, 1, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Course',),
           BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account'),
        ],
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Container(
          width:  MediaQuery.of(context).size.width,
          height:  MediaQuery.of(context).size.height,
          color: Color.fromRGBO(62, 196, 189, 1.0),
          child: Column(
            children: [
              screen[seletedIndex],
            ],
          ),
        ),
      ),
      ),
    );
  }

}