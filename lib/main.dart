import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunas_honda_absensi/absen.dart';
import 'package:tunas_honda_absensi/constants.dart';
import 'package:tunas_honda_absensi/constants.dart' as Constants;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:tunas_honda_absensi/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CJTP Absensi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'CJTP Absensi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  AnimationController animationController;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                        height: 300,
                        width: 200,
                        child: Image.asset(
                          'assets/logo_cjtp.png',
                        ),
                      ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Absensi CJTP ",style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("VER 1.0", style: TextStyle(fontSize: 12)),
                ],
              )
          ],
        ),
      )
      
      );
               
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int employeeId = prefs.getInt(Constants.EMPLOYEE_ID);

    if (employeeId==null || employeeId==0){
      Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(
        builder: (context) => Login()
      ), 
     ModalRoute.withName("/Login")
    );
    }else{
         Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(
        builder: (context) => Absen()
      ), 
     ModalRoute.withName("/Login")
    );

    }

  }


}
