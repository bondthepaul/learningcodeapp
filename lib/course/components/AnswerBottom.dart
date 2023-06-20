import 'dart:collection';
import 'package:learningcodeapp/model/answer.dart';
import 'package:learningcodeapp/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../model/question.dart';
class AnswerBottom extends StatefulWidget{
  List<Answer> answers;
  AnswerBottom({required this.answers});
  @override
  State<StatefulWidget> createState() => _AnswerBottom(answers:answers);
}
class _AnswerBottom extends State<AnswerBottom>
{
  List<Answer> answers;
  _AnswerBottom({required this.answers});
  int index=0;
  int preTap = -1;
  List<bool> button = List<bool>.generate(Answer.init().length, (index) => false);
  @override
  Widget build(BuildContext context) {
    if(answers.length==0)
      return Text("Empty");
      else
    return Container(
          decoration: const BoxDecoration(
              color: Color.fromRGBO(62, 196, 189, 1.0)
          ),
          child: Container(
            height:  MediaQuery.of(context).size.height*0.934/2,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: answers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          if(preTap!=-1) button[preTap]=!button[preTap];
                          button[index]=!button[index];
                          preTap=index;
                        },
                        child: Card(
                            elevation: 5,
                            margin: EdgeInsets.all(15),
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide.none),
                            color: button[index]?Color.fromRGBO(255, 255, 255, 1):Color.fromRGBO(255, 255, 255,  0.75),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(width: MediaQuery.of(context).size.width*0.45,margin: EdgeInsets.fromLTRB(15, 0, 0, 0), child: Text(answers[index].description.toString()),),
                                Container(width: MediaQuery.of(context).size.width*0.45,child: Padding(padding: EdgeInsets.all(15),child: Image(image: AssetImage(answers[index].image)),),),
                              ],
                            ),
                          ),
                        );
                    },
                  ),
                )
              ],
            ),
          ),
        );
  }

}
