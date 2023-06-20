import 'package:flutter/material.dart';
class Game{
  int id;
  int courseId;
  String title;
  String description;
  String layout;
  int amountToWin;
  Game({required this.id,required this.courseId,required this.title,required this.description,required this.layout,required this.amountToWin});
  static List<Game> init(){
    List<Game> data=[
      Game(id:1,courseId:1,title: "Game 1",description: "Get All Fuels To Get Out!",layout: "...........................*........................................................................",amountToWin: 1),
      Game(id:2,courseId:1,title: "Game 2",description: "Get All Fuels To Get Out!",layout: ".............*................................*.....................................................",amountToWin: 2),
      Game(id:3,courseId:1,title: "Game 3",description: "Get All Fuels To Get Out!",layout: ".................*..........*...............*.......................................................",amountToWin: 3),
      Game(id:4,courseId:1,title: "Game 4",description: "Get All Fuels To Get Out!",layout: "...........................*.......................................*................*...........*...",amountToWin: 4),
      Game(id:5,courseId:1,title: "Game 5",description: "Get All Fuels To Get Out!",layout: "...............*........*..........*..................*.........*...................................",amountToWin: 5),
    ];
    return data;
  }
}