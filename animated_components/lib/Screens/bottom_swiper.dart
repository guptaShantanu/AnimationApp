import 'package:animatedcomponents/Constants/constants.dart';
import 'package:flutter/material.dart';

class BottomSwiper extends StatefulWidget {
  @override
  _BottomSwiperState createState() => _BottomSwiperState();
}

class _BottomSwiperState extends State<BottomSwiper>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  double currentValue = 0.0;
  bool _canBeDragged = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
//    animation = CurvedAnimation(parent: animationController,curve: Curves.linear);
    animationController.value = 0.0;
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

  void onDragStart(DragStartDetails details) {
//    print(details.globalPosition.dy);
    bool isDragFromUp =
        animationController.isDismissed && details.globalPosition.dy < 80.0;
    bool isDragFromDown =
        animationController.isCompleted && details.globalPosition.dy < 400.0;

    _canBeDragged = isDragFromDown || isDragFromUp;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double dragDelta = details.primaryDelta / 310.0;
      print(details.primaryDelta);
//      setState(() {
      animationController.value += dragDelta;
//      });
    }
  }

  void open() {
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
  }

  void close() {
    animationController.reverse();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragStart: onDragStart,
          onVerticalDragUpdate: onDragUpdate,
          onVerticalDragEnd: (DragEndDetails details) {
            if (animationController.isCompleted ||
                animationController.isDismissed) {
              return;
            }
            if (details.velocity.pixelsPerSecond.dy.abs() >= 365.0) {
              double visualVelocity = details.velocity.pixelsPerSecond.dy /
                  MediaQuery.of(context).size.width;
              animationController.fling(velocity: visualVelocity);
            } else if (animationController.value < 0.5) {
              close();
            } else {
              open();
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: kLightThemeColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close, color: kDarkThemeColor),
                      alignment: Alignment.centerLeft,
                      onPressed: closeMyMenu,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Hello',
                      style: kDrawerTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Hello',
                      style: kDrawerTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Hello',
                      style: kDrawerTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Hello',
                      style: kDrawerTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: animationController,
                builder: (context, _) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..scale(1.0, 1.0)
                      ..translate(
                        0.0,
                        animationController.value * 250.0,
                      ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: kLightThemeColor,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kLightThemeColor,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      offset: Offset(0, 2),
                                      color: kDarkThemeColor)
                                ]),
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: kDarkThemeColor,
                                size: 30.0,
                              ),
                              onPressed: () {
                                showMyMenu();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
