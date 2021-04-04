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



class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Login Page'),
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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(clientId: Constants.CLIENT_ID_GMAIL);
    

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
                padding:
                    EdgeInsets.fromLTRB(defaultMargin, 50, defaultMargin, 0),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 10),
                          child: Text(
                            'Selamat Datang',
                            style: blackTextFont.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Selamat datang di aplikasi Absensi\nPT Ceria Jasatambang Pratama',
                            style: greyTextFont.copyWith(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Image.asset('assets/login-pic.png'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: 13),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(16)),
                            child: InkWell(
                              onTap: () async {
                          
                              String jobTit;
                              GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
                              GoogleSignInAuthentication googleAuth =await googleSignInAccount.authentication;

                              Map<String, String> body = {
                                'state': json.encode({
                                  'd': Constants.DB_NAME,
                                  'p': 3,
                                  'email': googleSignInAccount.email,
                                }),
                                'access_token': "",
                                'token_type': 'Bearer',
                              };

                           
                              final response =await http.post(
                                Constants.HOME_URL + Constants.URL_OAUTH_SIGNIN_WEB,
                                headers: null,
                                body: body,
                              );

                              if (response.statusCode == 200 || response.statusCode == '200') {
                                  Map<String, dynamic> json = jsonDecode(response.body);
                                  if (json.containsKey('employee_id')) {
                                    if (json['job'] is bool) {
                                      jobTit="";
                                    }else{
                                      jobTit=json['job'];
                                    }

                                  }
                                  Map<String, dynamic> user = json;
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString(Constants.GOOGLE_ACCESS_TOKEN, googleAuth.accessToken);
                                  prefs.setString(Constants.ODOO_ACCESS_TOKEN, json['access_token']);
                                  prefs.setInt(Constants.EMPLOYEE_ID, json['employee_id']);
                                  prefs.setString(Constants.NAME, json['user_name']);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Absen()),
                                  );

                              }else{
                                Map<String, dynamic> json = jsonDecode(response.body);
      
                                final snackBar = SnackBar(
                                        content: Text(json['message']),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ),
                                      );

                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              }

  
                               
                              },
                              child: Center(
                                child: Text(
                                  'Masuk dengan Google',
                                  style: whiteTextFont.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }


    @override
  void initState() {
  super.initState();
     getCurrentLocation();

  }

    getCurrentLocation() async {
      await Geolocator.getCurrentPosition();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  
  }


}

showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 7),
            child:Text("Tunggu sebentar ya.." ),
            ),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
