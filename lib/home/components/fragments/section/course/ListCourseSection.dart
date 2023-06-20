import 'package:learningcodeapp/course/CoursePage.dart';
import 'package:flutter/material.dart';
import 'package:learningcodeapp/model/course.dart';
import 'package:learningcodeapp/model/ultilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ListCourseSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListCourseSection();
}
class _ListCourseSection extends State<ListCourseSection>{
  late Future<List<Course>> coursesAPI = Ultilities().getCourses();
  static List<Course> course= Course.init();
  int preTap = -1;
  final myController = TextEditingController();
  List<bool> button = List<bool>.generate(course.length, (index) => false);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width:  MediaQuery.of(context).size.width,
        child:  FutureBuilder(
          future: coursesAPI,
            builder: (context,snapshot){
              if(snapshot.hasData) {
                button = List<bool>.generate(snapshot.data!.length, (index) => false);
                return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                itemBuilder: (BuildContext context,int index){
                  return GestureDetector(
                      onTap: () async{
                        setState(() {
                          if(preTap!=-1) button[preTap]=!button[preTap];
                          button[index]=!button[index];
                          preTap=index;
                        });
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setInt('course', snapshot.data![index].id);
                        prefs.setInt("attemps", 5);
                        Navigator.pushNamed(context, "/course",arguments: CourseArguments(course:snapshot.data![index]));
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: SizedBox(
                          width:  MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: button[index]? 20:10,
                            shadowColor: Colors.black,
                            color: button[index]? Color.fromRGBO(255, 255, 255, 0.5):Color.fromRGBO(255, 255, 255, 1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide.none),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(snapshot.data![index].image,height: 150,),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(snapshot.data![index].title.toString(),style: TextStyle(fontSize: 20,)),
                                    Text(snapshot.data![index].description.toString(),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  );
                }
            );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
        ),
      ),
    );
  }
}