import 'dart:collection';
import 'package:learningcodeapp/model/answer.dart';
import 'package:learningcodeapp/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../model/question.dart';
class Bottom extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Bottom();
}
class _Bottom extends State<Bottom>
{

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: const BoxDecoration(
              color: Color.fromRGBO(62, 196, 189, 1.0)
          ),
          child: Container(
            height:  MediaQuery.of(context).size.height*0.934/2,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      TextFormField(autocorrect: false,minLines: 1,maxLines: 50,
                        style: TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                          hintText: "Console command/..",
                          filled: true,
                          hintStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.black,
                          prefixIconColor: Colors.white,
                          prefixIcon: Icon(Icons.account_tree_outlined,color: Colors.white,),
                        ),
                        enabled: false,
                      ),
                      TextFormField(autocorrect: false,minLines: 1,maxLines: 50,
                        style: TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                          hintText: "Write code in here",
                          filled: true,
                          hintStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
  }

}
