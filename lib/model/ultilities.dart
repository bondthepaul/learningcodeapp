import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:learningcodeapp/model/answer.dart';
import 'package:learningcodeapp/model/course.dart';
import 'package:learningcodeapp/model/game.dart';
import 'package:learningcodeapp/model/question.dart';
import 'package:learningcodeapp/model/testhistory.dart';
import 'package:learningcodeapp/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Ultilities{
  Future<List<Course>> getCourses() async{
    List<Course> data = [];
    final res = await http.get(Uri.parse("https://basiclearningapp.000webhostapp.com/GetCourses.php"));
    if(res.statusCode == 200) {
      var content = res.body;
      var arr = json.decode(content);
      var list= List<Course>.from(arr.map((e) => _fromJson(e)));
      data=list;
      return list;
    }
    return [];
  }
  Course _fromJson(Map<String, dynamic> item) {
    return Course(
        description: item['description'],
        title: item['title'],
        image: item['image'],
        numberOfQuestions: int.parse(item['numberOfQuestion']), id: int.parse(item['courseId'])
    );
  }
  Future<List<TestHistory>> getTestHistory() async{
    var prefs = await SharedPreferences.getInstance();
    var user;
    if(!prefs.getString('username')!.isEmpty){
      user= prefs.getString('username');
    }
    final res = await Dio().post(
      'https://basiclearningapp.000webhostapp.com/GetUserHistory.php',
      data: FormData.fromMap({'user': user}),
    );
    if(res.statusCode == 200) {
      //print(res.data);
      if(res.data!="0 results")
      {var content = res.data;
      var arr = json.decode(content);
      var list= List<TestHistory>.from(arr.map((e) => _fromJsonTestHistory(e)));
      return list;}
      else
         return [];
    }
    return [];
  }
  TestHistory _fromJsonTestHistory(Map<String, dynamic> item) {
    return TestHistory(
        username: item['username'],
        courseId: int.parse(item['courseId']) ,
        testDate: DateTime.parse(item['testDate']) ,
        result: double.parse(item['result']) ,
        id: int.parse(item['testHistoryId'])
    );
  }
  Future<List<Question>> getQuestions() async{
    var prefs = await SharedPreferences.getInstance();
    var course;
    if(!prefs.getInt('course')!.isNaN){
      course= prefs.getInt('course');
    }
    final res = await Dio().post(
      'https://basiclearningapp.000webhostapp.com/GetQuestions.php',
      data: FormData.fromMap({'courseId': course}),
    );
    if(res.statusCode == 200) {
      var content = res.data;
      var arr = json.decode(content);
      var list= List<Question>.from(arr.map((e) => _fromJsonQuestion(e)));
      return list;
    }
    return [];
  }
  Question _fromJsonQuestion(Map<String, dynamic> item) {
    return Question(
        courseId: int.parse(item['courseId']) ,
        description: item['description'],
        title: item['title'],
        image: item['image'],
        rightAnswerId	: int.parse(item['rightAnswerId']),
        id: int.parse(item['questionId'])
    );
  }
  Future<List<Answer>> getAnswers(int questionid) async{
    final res = await Dio().post(
      'https://basiclearningapp.000webhostapp.com/GetAnswers.php',
      data: FormData.fromMap({'questionId': questionid}),
    );
    if(res.statusCode == 200) {
      var content = res.data;
      var arr = json.decode(content);
      var list= List<Answer>.from(arr.map((e) => _fromJsonAnswer(e)));
      return list;
    }
    return [];
  }
  Answer _fromJsonAnswer(Map<String, dynamic> item) {
    return Answer(
        description: item['description'],
        questionId: int.parse(item['questionId']),
        image: item['image'],
        id: int.parse(item['answerId'])
    );
  }
  Future<List<Game>> getGame() async{
    var prefs = await SharedPreferences.getInstance();
    var course;
    if(!prefs.getInt('course')!.isNaN){
      course= prefs.getInt('course');
    }
    final res = await Dio().post(
      'https://basiclearningapp.000webhostapp.com/GetGame.php',
      data: FormData.fromMap({'courseId': course}),
    );
    if(res.statusCode == 200) {
      var content = res.data;
      var arr = json.decode(content);
      print(arr);
      var list= List<Game>.from(arr.map((e) => _fromJsonGame(e)));
      return list;
    }
    return [];
  }
  Game _fromJsonGame(Map<String, dynamic> item) {
    return Game(
        description: item['description'],
        title: item['title'],
        courseId: int.parse(item['courseId']),
        layout: item['layout'],
        id: int.parse(item['gameId']),
        amountToWin: int.parse(item['amountToWin'])
    );
  }
  Future<List<User>> getUser() async{
    var prefs = await SharedPreferences.getInstance();
    var user;
    if(!prefs.getString('username')!.isEmpty){
      user= prefs.getString('username');
    }
    final res = await Dio().post(
      'https://basiclearningapp.000webhostapp.com/GetUser.php',
      data: FormData.fromMap({'email': user}),
    );
    //print("bru");
    if(res.statusCode == 200) {
      //print("bru");
      var content = res.data;
      var arr = json.decode(content);
      print(res.data);
      var list= List<User>.from(arr.map((e) => _fromJsonUser(e)));
      return list;
    }
    return [];
  }
  User _fromJsonUser(Map<String, dynamic> item) {
    return User(
        userId: int.parse(item['userId']),
        username: item['username'],
        password: item['password'],
        average: double.parse(item['average']),
        finishCourses: int.parse(item['finishCourses']),
        HighScore: int.parse(item['HighScore']),
        image: item['image']!=null? "":item['image']
    );
  }
}