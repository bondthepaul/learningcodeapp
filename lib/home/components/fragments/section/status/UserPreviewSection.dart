import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learningcodeapp/model/ultilities.dart';
import 'package:learningcodeapp/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreview extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _UserPreview();

  
}
class _UserPreview extends State<UserPreview>
{
  var prefs;
  var username= TextEditingController();
  Future<List<User>> user= Ultilities().getUser();
  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FutureBuilder(
        future: user,
        builder: (context,snapshot){
        if(snapshot.hasData)
          {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(child:  Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide.none),
                        elevation: 10,
                        shadowColor: Colors.black,
                        color: Color.fromRGBO(255, 255, 255, 0.75),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  backgroundColor: Color.fromRGBO(20, 77, 103, 1.0),
                                  radius: 50.0,
                                  child:CircleAvatar(
                                    child: Image.network("https://basiclearningapp.000webhostapp.com/userinfo.png"),
                                    backgroundColor: Colors.white,
                                    radius: 45.0,)
                              ),
                              SizedBox(width: 20,),
                              SizedBox(width: 200,
                                child: Table(
                                  children: [
                                    TableRow(
                                        children: [
                                          Text("Username:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                          Text(snapshot.data![0].username)
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          Text("High Score:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                          Text(snapshot.data![0].HighScore.toStringAsFixed(2))
                                        ]
                                    ),
                                    TableRow(

                                        children: [
                                          Text("Finished Courses:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                          Text(snapshot.data![0].finishCourses.toString())
                                        ]
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ),),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Average score",
                            style: TextStyle(
                                fontSize: 50,
                                color:  Color.fromRGBO(255, 255, 255, 1)
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Color.fromRGBO(41, 96, 86, 1.0),
                            radius: 70,
                            child: Text(snapshot.data![0].average.toStringAsFixed(0),
                              style: TextStyle(
                                  fontSize: 60,
                                  color:  Color.fromRGBO(255, 255, 255, 1)
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          );
          }
        else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
    });
  }
}