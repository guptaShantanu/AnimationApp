import 'package:flutter/material.dart';

class MyDrawerIconButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  const MyDrawerIconButton({
    this.iconData,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData,color:color,size: 35.0,),
    );
  }
}