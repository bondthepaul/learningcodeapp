import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class SeachHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      child: Column(
        children: [

          Center(child: Text("Course",style: TextStyle(color: Colors.black,fontSize: 30)),),
        ],
      ),
    );
  }
}