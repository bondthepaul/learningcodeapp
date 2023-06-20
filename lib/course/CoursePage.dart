import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learningcodeapp/game/GamePage.dart';
import 'package:learningcodeapp/model/answer.dart';
import 'package:learningcodeapp/model/course.dart';
import 'package:learningcodeapp/model/question.dart';
import 'package:learningcodeapp/model/ultilities.dart';
import 'package:learningcodeapp/splash/ScorePage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CoursePage extends StatefulWidget{
  static String routeName = "/course";
  @override
  _CoursePage createState() => _CoursePage();
}
class _CoursePage extends State<CoursePage>
{
  int indexQuestion = 0;
  List<Question> questions = Question.init();
  Question question= Question.init()[0];
  //int index=0;
  int preTap = -1;
  List<bool> button = [];
  List<int> correctAnswer=[];
  List<int> answer=[];
  List<String> previewAnswer = [];
  int score=0;
  bool generate=false;
  Future<List<Question>> questionsAPI= Ultilities().getQuestions();
  late int courseid;
  bool isClick=false;
  int clickIndex=-1;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _getData();
    timer = Timer.periodic(Duration(milliseconds: 100), (Timer t)
    {
      //print("honk");

      if(isClick) {
        for(var i in button)
          print(i.toString());
        print("-----------");
        setState(() {
          print( preTap.toString()+" honk "+clickIndex.toString());
          if(preTap!=-1) button[preTap]=!button[preTap];
          button[clickIndex]=!button[clickIndex];
          preTap=clickIndex;
      });
        for(var i in button)
          print(i.toString());
        print("-----------");
        isClick=false;
        clickIndex=-1;
      }
    });
  }
  _getData() async {
    var prefs = await SharedPreferences.getInstance();
    if(!prefs.getString('course')!.isEmpty){
      courseid = prefs.getInt('course')!;
    }
  }
  Future openQuestionAnswer()=> showDialog(context: context, builder: (context) =>AlertDialog(title: Text("List of answers:"),
    content: Container(width: MediaQuery.of(context).size.width*0.7,height: MediaQuery.of(context).size.width*0.5,
        child: ListView.builder(shrinkWrap: true,itemCount: previewAnswer.length, itemBuilder: (BuildContext context, int index){
          return Text("Question "+(index+1).toString()+": "+previewAnswer[index]);
        }),
    )
  ));

  @override
  Widget build(BuildContext context) {
    CourseArguments arguments= ModalRoute.of(context)!.settings.arguments as CourseArguments;

    return FutureBuilder(future: questionsAPI, builder: (context,snapshot){

      if(snapshot.hasData) {
        Future<List<Answer>> answersAPI = Ultilities().getAnswers(snapshot.data![indexQuestion].id);
        if(generate==false)
        {
          question=snapshot.data![0];
          for(var item in snapshot.data!)
          {
            correctAnswer.add(item.rightAnswerId);
            answer.add(-1);
            previewAnswer.add("");
          }
          generate=true;
        }
        return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap:() {
              Navigator.pop(context);
            },
            child:Icon(Icons.arrow_back_ios),
          ),
          bottomOpacity: 0.8,
          actions: [
            ElevatedButton(onPressed: (){openQuestionAnswer();}, child: Text((indexQuestion+1).toString()+"/"+snapshot.data!.length.toString()),),
            ElevatedButton(
              child: Icon(Icons.arrow_back),
              onPressed: (){
                setState(() {
                  print(indexQuestion.toString());
                  for(int i=0;i<button.length;i++)
                    button[i]=false;
                  preTap=-1;
                  if(indexQuestion>0) indexQuestion--;
                  question=snapshot.data![indexQuestion];
                  answersAPI=Ultilities().getAnswers(snapshot.data![indexQuestion].id) ;
                });

              },
            ),
            ElevatedButton(
              child: Icon(Icons.arrow_forward),
              onPressed: (){
                setState(() {
                  print(indexQuestion.toString());
                  if(indexQuestion<snapshot.data!.length-1) {
                    indexQuestion++;
                  }
                  for(int i=0;i<button.length;i++)
                    button[i]=false;
                  preTap=-1;
                  question=snapshot.data![indexQuestion];
                  answersAPI=Ultilities().getAnswers(snapshot.data![indexQuestion].id) ;
                });
              },
            ),
            ElevatedButton(
              child: Text("Submit"),
              onPressed: (){
                bool flag=false;
                score=0;
                for(int i=0;i<answer.length;i++)
                  {if(answer[i]==correctAnswer[i]) score+=10;
                   if(answer[i]==-1) flag=true;
                  }
                if(flag==true)
                { showDialog(context: context, builder: (context)=>AlertDialog(title: Text("Some questions still missing!!!"),
                    content: Container(width: MediaQuery.of(context).size.width*0.7,height: MediaQuery.of(context).size.width*0.5,
                      child: ListView.builder(shrinkWrap: true,itemCount: previewAnswer.length, itemBuilder: (BuildContext context, int index){
                        if(previewAnswer[index]=="") return Text("Question "+(index+1).toString()+": Missing",style: TextStyle(color: Colors.red),);
                        else return Text("Question "+(index+1).toString()+": "+previewAnswer[index]);
                      }),
                    ),
                  actions: [
                    ElevatedButton(

                      onPressed: (){Navigator.pushNamed(context, GamePage.routeName, arguments: GameArguments(course:arguments.course,score: score));},
                      child: Text("Submit anyway!!!"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: (){Navigator.of(context).pop();},
                      child: Text("Back"),
                    ),
                  ],
                )); }
                else
                Navigator.pushNamed(context, GamePage.routeName, arguments: GameArguments(course:arguments.course,score: score));
              },
            ),
          ],
          title: Text(arguments.course.title),
        ),
        body: Container(
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
                            child: Image.network(question.image,fit:  BoxFit.fill,),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: FutureBuilder(
          future: answersAPI,
          builder: (context,snapshott){
            if(snapshott.hasData)
              {
                if(button.length==0) button = List<bool>.generate(snapshott.data!.length, (index) => false);
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
                            itemCount: snapshott.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  isClick=true;
                                  clickIndex=index;
                                  answer[indexQuestion]=snapshott.data![index].id;
                                  previewAnswer[indexQuestion]=snapshott.data![index].description;
                                  String tmp="";
                                  for(var item in answer) {
                                    tmp+=item.toString()+" ";
                                  }
                                    print(tmp);
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
                                      Container(width: MediaQuery.of(context).size.width*0.45,margin: EdgeInsets.fromLTRB(15, 0, 0, 0), child: Text(snapshott.data![index].description.toString()),),
                                      Container(width: MediaQuery.of(context).size.width*0.42,child: Padding(padding: EdgeInsets.all(15),child: Image.network(snapshott.data![index].image,fit: BoxFit.fitHeight,)),),
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
            else if (snapshott.hasError) {
              return Text('${snapshott.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      );
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return const CircularProgressIndicator();
    });
}
}


class CourseArguments {
  final Course course;
  CourseArguments({required this.course});
}
