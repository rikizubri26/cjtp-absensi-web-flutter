import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunas_honda_absensi/appBar.dart';
import 'package:tunas_honda_absensi/appBar_view_widget.dart';
import 'package:tunas_honda_absensi/dateTime_view_widget.dart';
import '../../../../constants.dart';
import 'package:tunas_honda_absensi/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class Absen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:AttendanceViewBody()
      ),
    );
  }
}

class AttendanceViewBody extends StatefulWidget {
  @override
  _AttendanceViewBodyState createState() => _AttendanceViewBodyState();
}

class _AttendanceViewBodyState extends State<AttendanceViewBody> {
  var id;
  var date_absen;
  var jam_masuk;
  var jam_keluar;
  var work_place;
  var shift;

  String jamMasuk;

  final listChoices = <ItemChoice>[
    ItemChoice(1, 'Shift Pagi '),
    ItemChoice(2, 'Shift Malam'),
  ];
  var idSelected = 0;

  String _currentAddress="";
  Position currentPosition;

  
  


    @override
  Widget build(BuildContext context) {

    ProgressDialog loading,loading_post;
    loading = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.ltr,
      isDismissible: false,
    );


    loading.style(
        message: 'Mencari lokasi terupdate..',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ));


        
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: CustomAppBar(
            height: 100,
            child: CustomAppBarWidget(),
          ),
        body:  Column(
          children: [
            Flexible(
                flex: 2,
                child: DateTimeWidget(),
              ),

            Flexible(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32), 
                    ),
                    color: Colors.white,
                  ),
                   child: Container(
                     padding: EdgeInsets.all(24),
                     
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                           onTap: () async {
                             loading.show();
                             new Timer(const Duration(seconds: 2), () async {
                            
                             getCurrentLocation();
                              getAddressFromLatLng(); 
                            loading.hide();
                             });
                             
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              margin: EdgeInsets.only(right: 24),
                              decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: mainColor,
                                  ),
                              child: Icon(
                                    Icons.my_location,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                      'Lokasimu saat ini',
                                      style: blackTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                ),
                                Text( _currentAddress
                                ,style:greyTextFont.copyWith(fontSize: 12)
                                ,overflow: TextOverflow.ellipsis
                                ,maxLines: 2
                                ,softWrap: false
                                )
                              ]
                            )
                          )
                        ]
                      ),

                      SizedBox(
                         height: 220.0,
                         child: ListView(
                           children: [
                             SizedBox(
                                    height: 20.0,
                                  ),

                                  Center(
                                    child:Text(
                                      ['', null].contains(work_place)
                                                      ? 'Lokasi Kantor : Tidak terdeteksi'
                                                      : 'Lokasi Kantor : '+ work_place,
                                                  style: blackTextFont.copyWith(
                                                      fontSize: 11, fontWeight: FontWeight.w600),
                                    )
                                    ),

                                    Column(
                                        children: [
                                          Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                                  children: [
                                                    //jam masuk
                                                    Text(
                                                      ['', null].contains(jam_masuk)
                                                          ? '-- : --'
                                                          : jam_masuk,
                                                      style: blackTextFont.copyWith(
                                                          fontSize: 18, fontWeight: FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Masuk',
                                                      style: greyTextFont.copyWith(fontSize: 16),
                                                    ),
                                                  ],
                                                ),

                                          ),
                                          Container(
                                                child: Column(
                                                  children: [
                                                    //jam pulang
                                                     Text(
                                                      ['', null].contains(jam_keluar)
                                                          ? '-- : --'
                                                          : jam_keluar,
                                                      style: blackTextFont.copyWith(
                                                          fontSize: 18, fontWeight: FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Pulang',
                                                      style: greyTextFont.copyWith(fontSize: 16),
                                                    ),
                                                    
                                                  ],
                                                ), 
                                              ),
                                        ]

                                          )

                                        ]

                                    ),

                                    ['', null].contains(jam_masuk) ?

                                     Column(
                                       children: [
                                         Center(
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                                      Wrap(
                                                      children: listChoices
                                                        .map((e) => ChoiceChip(
                                                          selectedColor: Colors.blue,
                                                              label: Text(e.label),
                                                              labelStyle: TextStyle(color: Colors.white),
                                                              backgroundColor: Colors.black26,
                                                              selected: idSelected == e.id,
                                                              onSelected: (value) {
                                                                setState(() {
                                                                  idSelected = e.id;
                                                                  log(idSelected.toString());
                                                                });
                                                              },
                                                            
                                                            ))
                                                        .toList(),
                                                      spacing: 8,
                                                      ),  
                                                                                       
  
                                                  ],

                                           )

                                         ),

                                         Center(
                                              child: 
                                              idSelected == 0 ?
                                              Container(
                                              margin: EdgeInsets.only(top: 13),
                                              height: 50,
                                              width: 248,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              child: 
                                              
                                              InkWell(
                                                onTap: () async {
                                                    
                                                },
                                                child: Center(
                                                  child: Text(
                                                    "Silahkan pilih shift terlebih dahulu...",
                                                    style: whiteTextFont.copyWith(
                                                        fontSize: 14, color: Colors.blue),
                                                      
                                                  ),
                                                ),
                                                ),
                                                ) :
                                            Container(
                                              margin: EdgeInsets.only(top: 13),
                                              height: 50,
                                              width: 248,
                                              decoration: BoxDecoration(
                                                color: mainColor,
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              child: 
                                              
                                              InkWell(
                                                onTap: () async {
                                                  await showLoaderDialog(context);
                                                  int id=0;
                                                  if (id!=null){
                                                      id=id;
                                                  }

                                                  postMasuk();
                                                                                                
                                                  
                                                  
                                                                                                  },
                                                                                                  child: Center(
                                                                                                    child: Text(
                                                                                                      jam_masuk == null
                                                                                                          ? 'Absen Masuk'
                                                                                                          : 'Absen Keluar',
                                                                                                      style: whiteTextFont.copyWith(
                                                                                                          fontSize: 14, fontWeight: FontWeight.w600),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                  
                                                                                                )
                                                  
                                                                                         ]
                                                  
                                                                                       ):
                                                                                       Column(
                                                                                              children: [
                                                                                                ActionChip(
                                                                                        onPressed: () { 
                                                                                        },
                                                                                          label: Text(
                                                                                            ['', null].contains(shift) ?
                                                                                              '.....'
                                                                                            :
                                                                                             'Shift '+shift
                                                                                            ,style: TextStyle(color: Colors.white),),
                                                                                          backgroundColor: Colors.blue,
                                                                                        ),
                                                  
                                                                                                Center(
                                                                                                  child: Container(
                                                                                                    margin: EdgeInsets.only(top: 13),
                                                                                                    height: 50,
                                                                                                    width: 248,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: mainColor,
                                                                                                      borderRadius: BorderRadius.circular(16),
                                                                                                    ),
                                                                                                    child: 
                                                                                                    
                                                                                                    InkWell(
                                                                                                      onTap: () async {
                                                                                                        await showLoaderDialog(context);
                                                                                                        postKeluar();
                                                                                                      },
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                          jam_masuk == null
                                                                                                              ? 'Absen Masuk'
                                                                                                              : 'Absen Keluar',
                                                                                                          style: whiteTextFont.copyWith(
                                                                                                              fontSize: 14, fontWeight: FontWeight.w600),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),  
                                                  
                                                                             ],
                                                                             
                                                  
                                                                           )
                                                  
                                                                        )
                                                  
                                                                        ],
                                                                      )
                                                  
                                                                     )
                                                  
                                                                  )
                                                  
                                                              )
                                                  
                                                            ],
                                                          )
                                                          
                                                        )
                                                  
                                                      );
                                                  
                                                    }
                                                  
                                                  
@override
void initState() {
super.initState();
getAbsensi();
getCurrentLocation();

}
                                                  
  getCurrentLocation() async {
  await Geolocator.getCurrentPosition();
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  setState(() {
  currentPosition = position;
  _currentAddress=position.latitude.toString()+" " +position.longitude.toString();
  });
  getAddressFromLatLng();
  }

  getAddressFromLatLng() async {

  }
                                                  
                                                  
getAbsensi() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int employeeId = prefs.getInt(Constants.EMPLOYEE_ID);
    log(employeeId.toString());
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Map<String, String> body = {
    'params': json.encode({
    "employee_id": employeeId.toString(),
    "lat": position.latitude.toString(),
    "long": position.longitude.toString(),

    }),
    };

    final response =await http.post(
      Constants.HOME_URL+"/api/cni/v1/get_absensi_web",
      headers: null,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == '200') {
    Map<String, dynamic> json = jsonDecode(response.body);

    setState(() {
        jam_masuk=json['data'][0]['jam_masuk'];
        jam_keluar=json['data'][0]['jam_keluar'] ;
        date_absen=json['data'][0]['date_absen'];
        work_place=json['data'][0]['work_place'] ;
        shift=json['data'][0]['shift'] ;
        id=json['data'][0]['id'] ;

    });
    }

}
                                                  
void postMasuk() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int employeeId = prefs.getInt(Constants.EMPLOYEE_ID);
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Map<String, String> body = {
                              'params': json.encode({
                              "lat": position.latitude.toString(),
                              "long": position.longitude.toString(),
                              "check_in": "jamMasuk",
                              "employee_id": employeeId,
                              "db_name": Constants.DB_NAME,
                              "shift": idSelected.toString(),
                                
                              }),
                            };
                                
      final response =await http.post(
          Constants.HOME_URL+"/api/cni/v1/post_absen_masuk_web",
          headers: null,
          body: body,
        );
  
      if (response.statusCode == 200 || response.statusCode == '200') {
          getAbsensi();
          Navigator.pop(context);
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
}

void postKeluar() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int employeeId = prefs.getInt(Constants.EMPLOYEE_ID);
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  Map<String, String> body = {
                          'params': json.encode({
                          "lat": position.latitude.toString(),
                          "long": position.longitude.toString(),
                          "check_out": "jamKeluar",
                          "employee_id": employeeId.toString(),
                          "db_name": Constants.DB_NAME,
                          "id": id
                            }),
                          };
                              
    final response =await http.post(
        Constants.HOME_URL+"/api/cni/v1/post_absen_keluar_web",
        headers: null,
        body: body,
      );

    
    if (response.statusCode == 200 || response.statusCode == '200') {
          getAbsensi();
          Navigator.pop(context);
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


}

}

class ItemChoice {
  final int id;
  final String label;

  ItemChoice(this.id, this.label);
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


