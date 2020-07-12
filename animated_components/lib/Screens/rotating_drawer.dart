import 'package:animatedcomponents/Constants/constants.dart';
import 'package:animatedcomponents/Custom_Components/drawer_icon_button.dart';
import 'package:flutter/material.dart';

class RotatingDrawer extends StatefulWidget {
  @override
  _RotatingDrawerState createState() => _RotatingDrawerState();
}

class _RotatingDrawerState extends State<RotatingDrawer> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  double currentValue = 0.0;

  bool _canBeDragged = false;
  bool menu = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
//    animation = CurvedAnimation(parent: animationController,curve: Curves.linear);
//    Future.delayed(Duration(seconds: 3),(){start();});
  }

  void onDragStart(DragStartDetails details){
//    print(details.globalPosition.dy);
    bool isDragFromUp = animationController.isDismissed && details.globalPosition.dx> 1.0;
    bool isDragFromDown = animationController.isCompleted && details.globalPosition.dx< MediaQuery.of(context).size.width/5+10.0;

    _canBeDragged =  isDragFromDown||isDragFromUp;
  }

  void onDragUpdate(DragUpdateDetails details){
    if(_canBeDragged){
      double dragDelta = details.primaryDelta/MediaQuery.of(context).size.width/90.0;
      print(details.primaryDelta);
      setState(() {
        animationController.value += dragDelta;
      });
    }
  }


  void open(){
    animationController.forward();
    animationController.addListener(() { setState(() {

    });});
  }

  void close(){
    animationController.reverse();
    animationController.addListener(() { setState(() {
    });});
  }

  void showMyMenu() {
    animationController.forward(from: 0.0);
    animationController.addListener(() {
      currentValue = animationController.value;
      setState(() {});
    });
//    animation.addListener(() {
//      setState(() {
//
//      });
//    });
  }

  void closeMyMenu() {
    animationController.reverse(from: currentValue);
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: (){
                  menu?closeMyMenu():showMyMenu();
                  menu = !menu;
                },
                onHorizontalDragStart: onDragStart,
                onHorizontalDragUpdate: onDragUpdate,
                onHorizontalDragEnd: (DragEndDetails details){
                  if(animationController.isCompleted || animationController.isDismissed){
                    return;
                  }
                  if(details.velocity.pixelsPerSecond.dx.abs()>=MediaQuery.of(context).size.width/5+10.0){
                    double visualVelocity = details.velocity.pixelsPerSecond.dx/MediaQuery.of(context).size.width;
                    animationController.fling(velocity: visualVelocity);
                  }else if(animationController.value<0.5){
                    close();
                  }else{
                    open();
                  }
                },
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(MediaQuery.of(context).size.width/5*animationController.value,0),
                      child: Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(0.0-3.14/2*(animationController.value)),
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kLightThemeColor,
                            border: Border.all(width: 1.0,color: kDarkThemeColor)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              MyDrawerIconButton(iconData: Icons.menu,color: kDarkThemeColor,),
                              MyDrawerIconButton(iconData: Icons.person,color: kDarkThemeColor,),
                              MyDrawerIconButton(iconData: Icons.translate,color: kDarkThemeColor,),
                              MyDrawerIconButton(iconData: Icons.opacity,color: kDarkThemeColor,),
                              MyDrawerIconButton(iconData: Icons.map,color: kDarkThemeColor,),
                              MyDrawerIconButton(iconData: Icons.delete,color: kDarkThemeColor,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-MediaQuery.of(context).size.width/5*(1-animationController.value),0),
                      child: Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(3.14/2-(3.14/2*animationController.value)),
                        child:  Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kDarkThemeColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              MyDrawerIconButton(iconData: Icons.menu,color: kLightThemeColor,),
                              MyDrawerIconButton(iconData: Icons.person,color: kLightThemeColor,),
                              MyDrawerIconButton(iconData: Icons.translate,color: kLightThemeColor,),
                              MyDrawerIconButton(iconData: Icons.opacity,color: kLightThemeColor,),
                              MyDrawerIconButton(iconData: Icons.map,color: kLightThemeColor,),
                              MyDrawerIconButton(iconData: Icons.delete,color: kLightThemeColor,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: kLightThemeColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}


