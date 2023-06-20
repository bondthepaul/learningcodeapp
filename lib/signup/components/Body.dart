import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learningcodeapp/signup/components/SignUpForm.dart';
class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(62, 196, 189, 1.0)
        ),
        child: Column(
          children: [

            SignUpForm(),

          ],
        ),
      ),
    ));
  }

  Widget headerScreen(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.2,
      alignment: Alignment.bottomRight,

    );
  }
  Widget footerScreen(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomLeft,

    );
  }

}