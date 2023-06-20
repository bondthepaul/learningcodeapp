import 'package:learningcodeapp/model/question.dart';
import 'package:flutter/material.dart';
class Course{
  int id;
  String title;
  String description;
  String image;
  int numberOfQuestions;
  Course({required this.id,required this.title,required this.description,required this.image,required this.numberOfQuestions});
  static List<Course> init(){
    List<Course> data=[
      Course(id:1,title: "Level 1",description: "Basic of If",image: "assets/background.PNG",numberOfQuestions: 5),
      Course(id:2,title: "Level 2",description: "Basic of While",image: "assets/background.PNG",numberOfQuestions: 5),
      Course(id:3,title: "Level 3",description: "If and While integrate",image: "assets/background.PNG",numberOfQuestions: 5),
      Course(id:4,title: "Level 4",description: "Summary",image: "assets/background.PNG",numberOfQuestions: 5),
      Course(id:5,title: "Level 5",description: "End",image: "assets/background.PNG",numberOfQuestions: 5),
    ];
    return data;
  }
  static List<Question> getQuestion(int id)
  {
    List<Question> questions = Question.init();
    List<Question> data= List<Question>.empty();
    for(var item in questions)
    if(item.courseId==id)
    {
        data.add(item);
    }
    return data;
  }
}