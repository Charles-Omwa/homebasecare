import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lifeshare/utils/bottomAnimation.dart';
import 'package:lifeshare/utils/fadeAnimation.dart';


import 'auth.dart';
import 'availableservice.dart';
import 'covid.dart';



class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final FirebaseAuth appAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: new Text(
                "Exit Application",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: new Text("Are You Sure?"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  shape: StadiumBorder(),
                  color: Colors.white,
                  child: new Text(
                    "No",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  shape: StadiumBorder(),
                  color: Colors.white,
                  child: new Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(backgroundColor: Colors.deepPurple,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.065,
                ),
                FadeAnimation(
                  0.3,
                  Container(
                    margin: EdgeInsets.only(left: width * 0.05),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(color: Colors.black, fontSize: height * 0.04),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.09),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.2),
                      radius: height * 0.075,
                      child: Image(image: AssetImage("assets/doctor.png"), height: height * 0.2,),
                    ),
                    WidgetAnimator(patDocBtn('Medic', context)),
                    SizedBox(
                      height: height * 0.05,
                    ),

                    CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.2),
                      radius: height * 0.075,
                      child: Image(image: AssetImage("assets/bigPat.png"), height: height * 0.2,),
                    ),
                    WidgetAnimator(patDocBtn('Patient', context)),
                    SizedBox(
                      height: height * 0.075,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black87,
                      radius: height * 0.075,
                      child: Image(image: AssetImage("assets/covid.png"), height: height * 0.5,),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => CovidStats()));
                        },
                        color: Colors.white,
                        child: Text("Covid-19 Safety"),
                        shape: StadiumBorder(),
                      ),
                    ),


                    SizedBox(
                      height: 5,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget patDocBtn(String categoryText, context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.5,
      child: RaisedButton(
        onPressed: () {
          if (categoryText == 'Medic') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AuthPage(appAuth)));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>RequestPage()));
          }
        },
        color: Colors.white,
        child: Text("I am a" +" "+ categoryText),
        shape: StadiumBorder(),
      ),
    );
  }
}
