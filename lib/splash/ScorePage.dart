import 'package:learningcodeapp/home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ScorePage extends StatelessWidget{
  static String routeName="/score";
  @override
  Widget build(BuildContext context) {
    ScoreArguments arguments= ModalRoute.of(context)!.settings.arguments as ScoreArguments;
    new Future.delayed(new Duration(seconds: 3),(){
      Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName,(Route<dynamic> route) => false);
    } );
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Color.fromRGBO(62, 196, 189, 1.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Final result",
                style: TextStyle(
                    fontSize: 50,
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold),),
              CircleAvatar(
                backgroundColor: Color.fromRGBO(41, 96, 86, 1.0),
                radius: 70,
                child: Text(arguments.score.toString(),
                  style: TextStyle(
                      fontSize: 60,
                      color:  Color.fromRGBO(255, 255, 255, 1)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreArguments {
  final int score;
  ScoreArguments({required this.score});
}
