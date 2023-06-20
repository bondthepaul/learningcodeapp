import 'package:flutter/material.dart';
import 'package:learningcodeapp/home/components/fragments/section/account/Body.dart';
class AccountFragment extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height*0.934,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Body(),
              ],
            ),
          )
        ],
      ),
    );
  }
}