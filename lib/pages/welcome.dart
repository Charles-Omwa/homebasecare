import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeshare/utils/fadeAnimation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'category.dart';



class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scaleController2;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    super.initState();
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
    Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _widthController.forward();
        }
      });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _widthAnimation =
    Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _positionController.forward();
        }
      });

    _positionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _positionAnimation =
    Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          _scaleController2.forward();
        }
      });
    _scaleController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _scale2Animation = Tween<double>(begin: 1.0, end: 32.0).animate(
        _scaleController2)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.fade, child: Category()));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.black.withOpacity(0.1)));
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Container(
        width: width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: height * 0.05,
              left: width - 240,
              child: FadeAnimation(
                1,
                Container(height:600,
                  width: 330,
                  child: Image(image: AssetImage('assets/service.png',)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                height: height * 0.55,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          'Home Based Care',
                          style: TextStyle(color: Colors.black, fontWeight:FontWeight.bold,fontSize: height * 0.03),
                        )),
                    FadeAnimation(
                        1,
                        Text(
                          "Treatment at home!",
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.017),
                        )),
                    SizedBox(
                      height: height * 0.26,
                    ),
                    Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.6,
                            AnimatedBuilder(
                              animation: _scaleController,
                              builder: (context, child) => Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Center(
                                  child: AnimatedBuilder(
                                    animation: _widthController,
                                    builder: (context, child) => Container(
                                      width: _widthAnimation.value,
                                      height: 80,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          _scaleController.forward();
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            AnimatedBuilder(
                                              animation: _positionController,
                                              builder: (context, child) => Positioned(
                                                left: _positionAnimation.value,
                                                child: AnimatedBuilder(
                                                  animation: _scaleController2,
                                                  builder: (context, child) =>
                                                      Transform.scale(
                                                          scale: _scale2Animation
                                                              .value,
                                                          child: Container(
                                                              width: 60,
                                                              height: 60,
                                                              decoration:
                                                              BoxDecoration(
                                                                  color:
                                                                  Colors
                                                                      .black,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: hideIcon == false
                                                                  ? Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .white,
                                                              )
                                                                  : Container())),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: height * 0.02,),
                        FadeAnimation(
                            1,
                            Text(
                              'Proceed!', textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontSize: 20,color: Colors.white),
                            )),
                      ],
                    ),
                    SizedBox(height: height * 0.02,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
