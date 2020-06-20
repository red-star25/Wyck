import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Wyck_Home.dart';
class WyckLoading extends StatefulWidget {
  @override
  _WyckLoadingState createState() => _WyckLoadingState();
}

class _WyckLoadingState extends State<WyckLoading> {


  Future<Timer> timer()async{
    return Future.delayed(Duration(seconds:3),(){
      return Navigator.push(context, MaterialPageRoute(builder: (context)=>WyckHome()));
    });
  }


  @override
  void initState() {
    timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blueAccent,Colors.lightBlueAccent])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Wyck",style: GoogleFonts.workSans(fontWeight: FontWeight.bold,fontSize: 35),),
            SizedBox(height: 30,),
            SpinKitWave(
              color: Colors.yellow,
              size: 50.0,
            ),
          ],
        )
      ),
    );
  }
}
