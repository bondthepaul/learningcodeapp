import 'dart:collection';
import 'package:learningcodeapp/model/answer.dart';
import 'package:learningcodeapp/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../model/question.dart';
class QuestionBody extends StatefulWidget{
  Question question;
  QuestionBody({required this.question});
  @override
  State<StatefulWidget> createState() => _QuestionBody(question:question);
}
class _QuestionBody extends State<QuestionBody>
{
  Question question;
  _QuestionBody({required this.question});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: Container(
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
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width*0.75, 0),
                        child: Material(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.horizontal(left: Radius.zero,right: Radius.circular(20)),
                              side:  BorderSide.none),
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(41, 96, 86, 1.0),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(question.title,style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.75,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(question.description),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.20, 0, MediaQuery.of(context).size.width*0.20, 0),
                        child: Image(image: AssetImage(question.image),fit: BoxFit.fill),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}