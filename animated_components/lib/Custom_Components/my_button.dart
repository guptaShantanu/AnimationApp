import 'package:animatedcomponents/Constants/constants.dart';
import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final Function onTap;
  final String title;
  const MyButton({
    this.onTap,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(title,style: kButtonTextStyle,),
        decoration: BoxDecoration(
            color: kLightThemeColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [BoxShadow(blurRadius: 2.0,offset: Offset(2,2),color: kDarkThemeColor)]
        ),
      ),
    );
  }
}
