import'package:flutter/material.dart';
import 'package:lifeshare/screens/aok_screen.dart';
import 'package:lifeshare/screens/begin_screen.dart';
import 'package:lifeshare/screens/home_screen.dart';
import 'package:lifeshare/screens/in_quarantine_screen.dart';
import 'package:lifeshare/screens/start_screen.dart';
import 'package:lifeshare/screens/temperature_screen.dart';
import 'package:lifeshare/services/shared.dart';



class CovidNavigationScreen extends StatefulWidget {

  @override
  _CovidNavigationScreenState createState()=>_CovidNavigationScreenState();
}

class _CovidNavigationScreenState extends State<CovidNavigationScreen> {

  @override
  void initState() {
    super.initState();
    Shared.initShared();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Home care',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => StartScreen(),
        '/begin':(context) => BeginScreen(),
        '/temperature':(context) => TemperatureScreen(),
        '/inquarantine':(context) => InQuarantineScreen(),
        '/warning':(context) => HomeScreen(),
        '/aok':(context) => AOKScreen()
      },
    );
  }
}