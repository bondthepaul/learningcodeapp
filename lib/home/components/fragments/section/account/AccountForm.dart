import 'package:dio/dio.dart';
import 'package:learningcodeapp/home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learningcodeapp/model/ultilities.dart';
import 'package:learningcodeapp/model/user.dart';
class AccountForm extends StatefulWidget {
  @override
  _AccountForm createState() => _AccountForm();
}

class _AccountForm extends State<AccountForm> {
  Future<List<User>> user=Ultilities().getUser();
  var emailtxt= TextEditingController();
  var passwordtxt= TextEditingController();
  var repasswordtxt= TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder( future: user,builder: (context,snapshot){
      if(snapshot.hasData)
        {
          emailtxt.text=snapshot.data![0].username;
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
                            "Account Info",
                            style: TextStyle(
                                fontSize: 50,
                                color:  Color.fromRGBO(255, 255, 255, 1),
                                fontWeight: FontWeight.bold),),
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
                              controller: emailtxt,
                              enabled: false,
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40),borderSide: BorderSide(width: 0,style: BorderStyle.none)),
                                hintText: "Email",
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
                              controller: passwordtxt,
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40),borderSide: BorderSide(width: 0,style: BorderStyle.none)),
                                hintText: "Password",
                                filled: true,
                                prefixIcon: Icon(Icons.password),
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
                              controller: repasswordtxt,
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40),borderSide: BorderSide(width: 0,style: BorderStyle.none)),
                                hintText: "Re-Password",
                                filled: true,
                                prefixIcon: Icon(Icons.password),
                                prefixIconColor: Colors.lightBlue,
                              ),
                            ),
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
                                if(passwordtxt.text == repasswordtxt.text) {
                                  final res = await Dio().post(
                                    'https://basiclearningapp.000webhostapp.com/UpdateAccount.php',
                                    data: FormData.fromMap({'email': emailtxt.text,'password': passwordtxt.text}),
                                  );
                                  if(res.statusCode == 200) {
                                    var content = res.data;
                                    print(content);
                                    if(content.toString()=="true")
                                      Navigator.pop(context);
                                    else
                                      Fluttertoast.showToast(msg: content.toString());
                                  }

                                }
                                else Fluttertoast.showToast(msg: "pass not match");
                              },
                              child: Text("Save", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return const CircularProgressIndicator();
    });
  }
}