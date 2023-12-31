
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    super.initState();

    Timer(
        Duration(seconds:2) , (){
          Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context) => HomeScreen()));
    });

  }


  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/new_img/shopping.jpeg',
              fit: BoxFit.cover,
              // width: width * .9,
              height:  height * .5,
            ),
            SizedBox(height: height * 0.04),
            Text('Shopping', style: GoogleFonts.anton(letterSpacing: 0.6, color: Colors.grey.shade700),),
            SizedBox(height: height * 0.04),
            SpinKitChasingDots(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
