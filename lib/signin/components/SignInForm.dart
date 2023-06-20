import 'package:dio/dio.dart';
import 'package:learningcodeapp/home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learningcodeapp/signup/SignUpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final username = TextEditingController();
  final password = TextEditingController();
  var prefs;
  @override
  void initState() {
    super.initState();
    _getData();
  }
  _getData() async {
    prefs = await SharedPreferences.getInstance();
    if(!prefs.getString('username').isEmpty){
      print("lol");
      username.text = prefs.getString('username');
      password.text = prefs.getString('password');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Basic Coding",
                      style: TextStyle(
                          fontSize: 50,
                          color:  Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.bold),),
                    Text(
                      "Are you ready to learn the basic of coding?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:  Color.fromRGBO(255, 255, 255, 0.5)
                      ),
                    )
                  ],
                )),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      elevation: 10.0,
                      shadowColor: Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                      child: TextFormField(
                        controller: username,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40),borderSide: BorderSide(width: 0,style: BorderStyle.none)),
                          hintText: "Username",
                          filled: true,
                          prefixIcon: Icon(Icons.mail_outline),
                          prefixIconColor: Colors.lightBlue,
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),
                    Material(
                      elevation: 10.0,
                      shadowColor: Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40),borderSide: BorderSide(width: 0,style: BorderStyle.none)),
                          hintText: "Password",
                          filled: true,
                          prefixIcon: Icon(Icons.lock_outline_rounded),

                          prefixIconColor: Colors.lightBlue,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                              fontSize: 14),),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignUpPage.routeName);
                            },
                            child: Text(
                              " Sign Up",
                              style: TextStyle(
                                  color:Color.fromRGBO(255, 255, 255, 1.0),
                                  fontSize: 14),)
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStatePropertyAll(10),
                          shadowColor: MaterialStatePropertyAll(Colors.blue),
                          surfaceTintColor: MaterialStatePropertyAll(Colors.white),

                        ),
                        onPressed: () async {
                          Fluttertoast.showToast(msg: "Do something");
                          print(username.text+" "+password.text);
                          prefs = await SharedPreferences.getInstance();
                          prefs.setString('username', username.text);
                          prefs.setString('password', password.text);
                          prefs.setInt('attemps',5);
                          final res = await Dio().post(
                            'https://basiclearningapp.000webhostapp.com/ConfirmEmail.php',
                            data: FormData.fromMap({'email': username.text,'password': password.text}),
                          );
                          if(res.statusCode == 200) {
                            var content = res.data;
                            if(content.toString()=="true") Navigator.pushNamed(context, HomePage.routeName);
                            else { Fluttertoast.showToast(msg: "Can't find this user");}
                          }
                          else{
                            Fluttertoast.showToast(msg: "Connection error");
                          }
                        },
                        child: Text("Sign In", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),),
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}