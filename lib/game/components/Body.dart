import 'dart:collection';
import 'package:learningcodeapp/model/answer.dart';
import 'package:learningcodeapp/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learningcodeapp/model/game.dart';
import '../../model/question.dart';
class Body extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Body();
}
class _Body extends State<Body>{
  Game game = Game.init()[0];
  int x=0;
  int y=0;
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
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
            ),
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width/10,
                    height: MediaQuery.of(context).size.width/10,
                    child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),side: BorderSide.none),
                        child: index==(y*10+x)?Center(child: Image.network("https://basiclearningapp.000webhostapp.com/robot.png"),): Center(child: game.layout[index]=='*'?  Image.network("https://basiclearningapp.000webhostapp.com/fuel.png"):Text(game.layout[index]),),
                    ),
                  );
              },

            )
          ),
        ),
      ),
    );
  }

}