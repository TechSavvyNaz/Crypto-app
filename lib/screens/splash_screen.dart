import 'dart:async';
import 'package:flutter/material.dart';
import 'package:digital/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Replace 'Icons.cloud' with your app's logo icon if available
            Image.asset(
              'images/logo.png',
              width: 100.0,  // Set the width to 100.0 pixels
              height: 100.0, // Set the height to 100.0 pixels
              fit: BoxFit.cover, // Cover the entire widget area, adjusting the aspect ratio
            ),
            SizedBox(height: 20),
            Text('Digital Products', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink[800])),
          ],
        ),
      ),
    );
  }
}
