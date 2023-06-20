import 'package:flutter/material.dart';
class Answer{
  int id;
  int questionId;
  String description;
  String image;
  Answer({required this.id,required this.questionId,required this.description,required this.image});
  static List<Answer> init(){
    List<Answer> data=[
      Answer(id:1,questionId:1,description: "We use if for executing a different statement in case the original if expression evaluates to false",image: "assets/background.PNG"),
      Answer(id:2,questionId:1,description: "We use if for fun",image: "assets/background.PNG"),
      Answer(id:3,questionId:1,description: "We use if for reason",image: "assets/background.PNG"),
      Answer(id:4,questionId:1,description: "Why are we using if again",image: "assets/background.PNG"),
    ];
    return data;
  }
  static List<Answer> questionanswer(int question){
    List<Answer> data=[];
    for(var i in Answer.init())
      if(i.questionId==question) data.add(i);
    return data;
  }
}