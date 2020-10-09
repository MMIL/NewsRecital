import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_retic/Screens/HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 180, width: 180, child: Image.asset("asset/newicon.png")),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'News',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        letterSpacing: .4,
                        fontSize: 28.0,
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  'Recital',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        letterSpacing: .4,
                        color: Colors.deepPurple,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
