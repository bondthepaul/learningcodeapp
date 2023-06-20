import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learningcodeapp/home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learningcodeapp/signin/SignInPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var email=TextEditingController();
  var password=TextEditingController();
  var repassword=TextEditingController();
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
                      "Sign Up",
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
                        controller: email,
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
                    Material(
                      elevation: 10.0,
                      shadowColor: Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                      child: TextFormField(
                        controller: repassword,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40),borderSide: BorderSide(width: 0,style: BorderStyle.none)),
                          hintText: "Retype Password",
                          filled: true,
                          prefixIcon: Icon(Icons.account_box),
                          prefixIconColor: Colors.lightBlue,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                              fontSize: 14),),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignInPage.routeName);
                            },
                            child: Text(
                              " Sign In",
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
                        onPressed: () async{
                          final res = await Dio().post(
                            'https://basiclearningapp.000webhostapp.com/CreateAccount.php',
                            data: FormData.fromMap({'email': email.text,'password': password.text}),
                          );
                          if(res.statusCode == 200) {
                            var content = res.data;
                            print(content);
                            if(content.toString()=="true")
                              {
                                var prefs = await SharedPreferences.getInstance();
                                prefs.setString('username', email.text);
                                prefs.setString('password', password.text);
                                Navigator.pushNamed(context, SignInPage.routeName);
                              }
                            else
                              Fluttertoast.showToast(msg: content.toString());
                          }
                          },
                        child: Text("Sign Up", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),),
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