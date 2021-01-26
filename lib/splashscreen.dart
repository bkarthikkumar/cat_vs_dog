import 'package:cat_vs_dog/homeScree.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySpalshScreen extends StatefulWidget {
  @override
  _MySpalshScreenState createState() => _MySpalshScreenState();
}

class _MySpalshScreenState extends State<MySpalshScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Home(),
      title: Text(
        'Dog and Cat Spalsh',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Color(0xFFE99600),
        ),
      ),
      image: Image.asset(
        'assets/cat.png',
      ),
      backgroundColor: Colors.black,
      photoSize: 50,
      loaderColor: Color(0xFFEDA28),
    );
  }
}
