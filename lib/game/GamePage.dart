import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learningcodeapp/game/components/Bottom.dart';
import 'package:learningcodeapp/model/course.dart';
import 'package:learningcodeapp/game/components/Body.dart';
import 'package:learningcodeapp/model/game.dart';
import 'package:learningcodeapp/model/question.dart';
import 'package:learningcodeapp/model/ultilities.dart';
import 'package:learningcodeapp/splash/ScorePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GamePage extends StatefulWidget{
  static String routeName = "/game";
  @override
  _GamePage createState() => _GamePage();
}
class Layer{
  int x;int y; int look;
  Layer({required this.x,required this.y,required this.look});
}
void SubmitScore(int attemp,int score,BuildContext context,int courseid,String email) async{
  var pref=await SharedPreferences.getInstance();
  pref.setInt("attemps", 5);
  if(attemp>0) score+=attemp*10;
  final res = await Dio().post(
    'https://basiclearningapp.000webhostapp.com/CreateTestHistory.php',
    data: FormData.fromMap({'result': score,'courseId': courseid,'username':email}),
  );
  if(res.statusCode == 200) {
    var content = res.data;
    print(content);
    if(content.toString()=="truetruetrue")
      Navigator.pushNamed(context, ScorePage.routeName,arguments:ScoreArguments(score: score));
    else
      Fluttertoast.showToast(msg: content.toString());
    //Navigator.pushNamed(context, ScorePage.routeName,arguments:ScoreArguments(score: score));
  }
}
class _GamePage extends State<GamePage>
{
  int x=0;
  int y=0;
  int lookat=0;
  int animations=0;
  int animationplayer=0;
  List<Layer> layers=[];
  late int courseid;
  int attemp=5;
  late int score;
  bool postResult=false;
  var email;
  var fakeLayout=[];
  Timer? timer;
  Future<List<Game>> gameAPI= Ultilities().getGame();
  TextEditingController code = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getData();
    for(int i=1;i<=100;i++)
      fakeLayout.add('.');
    layers.add(Layer(x: 0, y: 0, look: 0));
    layers.add(Layer(x: 0, y: 0, look: 1));
    layers.add(Layer(x: 0, y: 0, look: 2));
    layers.add(Layer(x: 0, y: 0, look: 3));
    animations=4;
    timer = Timer.periodic(Duration(milliseconds: 350), (Timer t) async
        {
      print("honk");
    if(animations!=0) {
      if(animationplayer==animations) {
        animations=0;
        layers=[];
        animationplayer=0;
        if(postResult==true) SubmitScore(attemp, score, context, courseid, email);
        setState(() {
          x=0;y=0;lookat=0;
        });
      }
      setState(() {
        x=layers[animationplayer].x;
        y=layers[animationplayer].y;
        lookat=layers[animationplayer].look;
        if(fakeLayout[x+y*10]=='*') fakeLayout[x+y*10]='.';
        animationplayer++;
      });

    }
    });
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  _getData() async {
    var prefs = await SharedPreferences.getInstance();
    if(!prefs.getInt('course')!.isNaN){
      courseid = prefs.getInt('course')!;
    }
    if(!prefs.getInt('attemps')!.isNaN){
      attemp = prefs.getInt('attemps')!;
    }
    if(!prefs.getString('username')!.isEmpty){
      email = prefs.getString('username')!;
    }
  }
  Future openTutorial()=> showDialog(context: context, builder: (context) =>AlertDialog(title: Text("How to play:"),content: Text("-Write left to turn Left\n-Write right to turn Right\n-Write forward to go forward 1 step\n-Write\nwhile 'number'\nbegin\n'list of command'\nend\nto repeat that list of command"),));
  @override
  Widget build(BuildContext context) {

    List<String> sprites=[];
    sprites.add("https://basiclearningapp.000webhostapp.com/right.png");
    sprites.add("https://basiclearningapp.000webhostapp.com/down.png");
    sprites.add("https://basiclearningapp.000webhostapp.com/left.png");
    sprites.add("https://basiclearningapp.000webhostapp.com/up.png");

    GameArguments arguments= ModalRoute.of(context)!.settings.arguments as GameArguments;
    score = arguments.score;

    return FutureBuilder(future: gameAPI, builder: (context,snapshot){
      if(snapshot.hasData)
        {
          if(animations==0) {fakeLayout=snapshot.data![0].layout.split("");
          for(var i in fakeLayout)
            print(i);
          }
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap:() async{
                  var pref=await SharedPreferences.getInstance();
                  pref.setInt("attemps", attemp);
                  Navigator.pop(context);
                },
                child:Icon(Icons.arrow_back_ios),
              ),
              bottomOpacity: 0.8,
              actions: [

                ElevatedButton(
                  child: Icon(Icons.school),
                  onPressed: (){
                    openTutorial();
                  },
                ),
                ElevatedButton(
                  child: Text("Attemps left:"),
                  onPressed: (){  },
                ),
                ElevatedButton(
                  child: Text(attemp.toString()),
                  onPressed: (){  },
                ),
                ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () async {
                    if(animations==0)
                      {
                        {
                          bool isOutOfBound=false;
                          bool isStepOnSpike=false;
                          List<String> ss= code.text.split("\n");
                          x=0;y=0;lookat=0;
                          int j=0;
                          int moveIndex = 0;
                          bool validFormat = true;
                          List<String> move=[];
                          move.add("");
                          for(var i in ss)
                          {
                            var s=i.toLowerCase().trim();
                            s=s.replaceAll(RegExp(r"\s+"), " ");
                            i=s;
                            bool valid=false;
                            int tam=0;
                            bool iswhile= i.contains("while");
                            if(iswhile==true) tam++;
                            bool isforward= i.contains("forward");
                            if(isforward==true) tam++;
                            bool isright= i.contains("right");
                            if(isright==true) tam++;
                            bool isleft= i.contains("left");
                            if(isleft==true) tam++;
                            bool isbegin= i.contains("begin");
                            if(isbegin==true) tam++;
                            bool isend= i.contains("end");
                            if(isend==true) tam++;
                            if(tam==1) valid=true;
                            if(iswhile&&valid) { var tmp= s.split(" "); if(tmp.length>2) valid=false; if(int.tryParse(tmp[1])==null) valid=false;  }
                            if(isforward&&valid) {if(s.toString().length!=7) valid = false; }
                            if(isright&&valid) {if(s.toString().length!=5) valid = false; }
                            if(isleft&&valid) {if(s.toString().length!=4) valid = false; }
                            if(isbegin&&valid) {if(s.toString().length!=5) valid = false; }
                            if(isend&&valid) {if(s.toString().length!=3) valid = false; }
                            if(valid==false) {Fluttertoast.showToast(msg: "wrong code format at line:$j");validFormat=false;}
                            j++;
                            i=s;
                          }
                          if(validFormat==true)
                          {
                            List<String> brace=[];
                            bool validBrace = true;
                            List<int> repeat=[];
                            for(var i in ss)
                            {
                              bool iswhile= i.contains("while");
                              bool isforward= i.contains("forward");
                              bool isright= i.contains("right");
                              bool isleft= i.contains("left");
                              bool isbegin= i.contains("begin");
                              bool isend= i.contains("end");
                              if(iswhile && moveIndex==0) {
                                moveIndex++;
                                var tmp= i.split(" ");
                                move.add(tmp[1].toString());
                                repeat.add(int.parse(tmp[1]));
                              }
                              else if(iswhile && move[moveIndex].length!=0) {
                                moveIndex++;
                                var tmp= i.split(" ");
                                move.add(tmp[1].toString());
                                repeat.add(int.parse(tmp[1]));
                              }
                              else if(iswhile && int.tryParse(move[moveIndex])!=null) {
                                //print("honk wtf"+move[moveIndex]);
                                var tmp= i.split(" ");
                                move[moveIndex]=(int.parse(move[moveIndex])*int.parse(tmp[1])).toString();
                                repeat.last=repeat.last*int.parse(tmp[1]);
                              }
                              if(isforward) move[moveIndex]=move[moveIndex]+'f';
                              if(isright) move[moveIndex]=move[moveIndex]+'r';
                              if(isleft) move[moveIndex]=move[moveIndex]+'l';
                              if(isbegin && move[moveIndex].length!=0) {moveIndex++;move.add("{");moveIndex++;move.add("");brace.add("{");}
                              if(isend) { if(move.last=="" && move[move.length-2]=="}"){move.last=move.last+"}";} else {moveIndex++;move.add("}"); } moveIndex++;move.add("");if(brace.length>0) brace.removeAt(brace.length-1); else validBrace=false;}
                            }
                            if(brace.length!=0) validBrace= false;
                            if(validBrace==false) Fluttertoast.showToast(msg: "Invalid braces");
                          }
                          List<int> braceloop=[];
                          List<int> repeat=[];
                          List<int> xmove=[];xmove.add(1);xmove.add(0);xmove.add(-1);xmove.add(0);
                          List<int> ymove=[];ymove.add(0);ymove.add(1);ymove.add(0);ymove.add(-1);
                          for(var i in move)
                          {
                            print(i);
                          }

                          var gametmp=snapshot.data![0].layout.split("");
                          int numfuel=0;
                          int xx=x,yy=y;int lookatt=lookat;
                          for(int i=0;i<move.length;i++)
                          {
                            print(xx.toString()+" "+yy.toString()+" look:"+lookatt.toString());
                            if(repeat.length!=0 && braceloop.length!=0) print(" "+repeat.last.toString()+" "+braceloop.last.toString());
                            if(int.tryParse(move[i])!=null) { repeat.add(int.parse(move[i])); }
                            else if(move[i]=="{") { braceloop.add(i); }
                            else if(move[i]=="}") { if(repeat.last!=1) {repeat.last--;i=braceloop.last;} else {repeat.removeAt(repeat.length-1);braceloop.removeAt(braceloop.length-1);} }
                            else {
                              for (int j = 0; j < move[i].length; j++) {
                                if (move[i][j] == 'f') { setState(() {
                                  xx+=xmove[lookatt];yy+=ymove[lookatt];
                                  if(layers.length==0) { layers.add(Layer(x: 0, y: 0, look: 0));}
                                  layers.add(Layer(x: xx, y: yy, look: lookatt));
                                });

                                if(gametmp[xx+yy*10]=='*') {numfuel++;gametmp[xx+yy*10]='.';}
                                if(gametmp[xx+yy*10]=='-') {   isStepOnSpike=true; break; }
                                if(xx>9||xx<0) {isOutOfBound=true;layers.removeAt(layers.length-1); break;}
                                if(yy>9||yy<0) {isOutOfBound=true;layers.removeAt(layers.length-1); break;}
                                }
                                else if (move[i][j] == 'l') { if(lookatt==0) lookatt=3;else if(lookatt==1) lookatt=0; else if(lookatt==2) lookatt=1; else if(lookatt==3) lookatt=2; }
                                else if (move[i][j] == 'r') { if(lookatt==0) lookatt=1;else if(lookatt==1) lookatt=2; else if(lookatt==2) lookatt=3; else if(lookatt==3) lookatt=0; }
                              }
                            }
                            if(isOutOfBound||isStepOnSpike) break;
                          }
                          animations=layers.length;
                          for(var i in layers)
                          {
                            print(i.x.toString()+" "+i.y.toString()+" "+i.look.toString());
                          }
                          if(numfuel==snapshot.data![0].amountToWin) {
                            postResult=true;
                            /*
                            if(attemp>0) score+=attemp*10;
                            final res = await Dio().post(
                              'https://basiclearningapp.000webhostapp.com/CreateTestHistory.php',
                              data: FormData.fromMap({'result': score,'courseId': courseid,'username':email}),
                            );
                            if(res.statusCode == 200) {
                              var content = res.data;
                              print(content);
                              if(content.toString()=="truetruetrue")
                                Navigator.pushNamed(context, ScorePage.routeName,arguments:ScoreArguments(score: score));
                              else
                                Fluttertoast.showToast(msg: content.toString());
                              //Navigator.pushNamed(context, ScorePage.routeName,arguments:ScoreArguments(score: score));
                            }*/

                          } else {
                            setState(() {
                              attemp--;
                            });
                            if(attemp==0) {
                              postResult=true;
                              /*
                              final res = await Dio().post(
                                'https://basiclearningapp.000webhostapp.com/CreateTestHistory.php',
                                data: FormData.fromMap({'result': 0,'courseId': courseid,'username':email}),
                              );
                              if(res.statusCode == 200) {
                                var content = res.data;
                                print(content);
                                if(content.toString()=="truetruetrue")
                                  Navigator.pushNamed(context, ScorePage.routeName,arguments:ScoreArguments(score: score));
                                else
                                  Fluttertoast.showToast(msg: content.toString());
                              }*/
                            }
                            if(isStepOnSpike)
                            Fluttertoast.showToast(msg: "Step on spikes");
                            else if(isOutOfBound)
                              Fluttertoast.showToast(msg: "Out of bound");
                            else Fluttertoast.showToast(msg: "Lack of fuel");
                          }
                        }
                      }

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
                      child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              child: index==(y*10+x)?Center(child: Image.network(sprites[lookat]),): Center(child: fakeLayout[index]=='*'?  Image.network("https://basiclearningapp.000webhostapp.com/fuel.png"):fakeLayout[index]=='-'?Image.network("https://basiclearningapp.000webhostapp.com/spikes.png"):Text(fakeLayout[index]),),
                            ),
                          );
                        },
                      )
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
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
                          TextFormField(autocorrect: false,
                            minLines: 1,maxLines: 50,
                            style: TextStyle(color: Colors.white),
                            decoration:  InputDecoration(
                              hintText: "Console command/..",
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.black,
                              prefixIconColor: Colors.white,
                              prefixIcon: Icon(Icons.account_tree_outlined,color: Colors.white,),
                            ),
                            enabled: false,
                          ),
                          TextFormField(
                            autocorrect: false,minLines: 1,maxLines: 50,

                            style: TextStyle(color: Colors.white),
                            controller: code,
                            decoration:  InputDecoration(
                              hintText: "Write code in here",
                              filled: true,
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return const CircularProgressIndicator();

    });
  }
}


class GameArguments {
  final Course course;
  final int score;
  GameArguments({required this.course,required this.score});
}

