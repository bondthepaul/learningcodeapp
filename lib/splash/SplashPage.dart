import 'package:learningcodeapp/signin/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:app/signin/signinpage.dart';

class SplashPage extends StatelessWidget{
  static String routeName="/splash";
  @override
  Widget build(BuildContext context) {

    new Future.delayed(new Duration(seconds: 3),(){
      Navigator.pushNamedAndRemoveUntil(context, SignInPage.routeName,(Route<dynamic> route) => false);
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
              CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Color.fromRGBO(41, 96, 86, 1.0),
                strokeWidth: 5,
              ),
              SizedBox(height: 5,),
              Text('Loading...',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
            ],
          ),
        ),
      ),
    );
  }

}