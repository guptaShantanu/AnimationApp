import 'package:animatedcomponents/Constants/constants.dart';
import 'package:animatedcomponents/Custom_Components/my_button.dart';
import 'package:animatedcomponents/Screens/bottom_swiper.dart';
import 'package:animatedcomponents/Screens/rotating_drawer.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text('Animation',style: kTitleTextStyle),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            MyButton(title: 'Bottom Swiper',onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomSwiper()));
            },),
            MyButton(title: 'Rotating Drawer',onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>RotatingDrawer()));
            },)
          ],
        ),
      ),
    );
  }
}
