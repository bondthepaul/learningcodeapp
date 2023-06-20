import 'package:flutter/material.dart';
class Question{
  int id;
  int courseId;
  String title;
  String description;
  String image;
  int rightAnswerId;
  Question({required this.id,required this.courseId,required this.title,required this.description,required this.image,required this.rightAnswerId});
  static List<Question> init(){
    List<Question> data=[
      Question(id:1,courseId:1,title: "Question 1",description: "Why do we use if?",image: "assets/background.PNG",rightAnswerId: 1),
      Question(id:2,courseId:1,title: "Question 2",description: "Why do we use while?",image: "assets/background.PNG",rightAnswerId: 2),
      Question(id:3,courseId:1,title: "Question 3",description: "How can we integrate if with while ?",image: "assets/background.PNG",rightAnswerId: 3),
      Question(id:4,courseId:1,title: "Question 4",description: "If definition",image: "assets/background.PNG",rightAnswerId: 4),
      Question(id:5,courseId:1,title: "Question 5",description: "While definition",image: "assets/background.PNG",rightAnswerId: 5),
    ];
    return data;
  }
}