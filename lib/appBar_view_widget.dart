// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tunas_honda_absensi/application/auth/auth_bloc.dart';
// import 'package:tunas_honda_absensi/presentation/pages/assessment/assessment_page.dart';

import '../../../../constants.dart';
import 'package:tunas_honda_absensi/constants.dart' as Constants;


// ignore: must_be_immutable
class CustomAppBarWidget extends StatefulWidget {
  // var name = getIt<SharedPreferences>().getString(Constants.NAME);
  

  @override
  _CustomAppBarWidgetState createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  String _name = '';

  @override
  void initState() {
    super.initState();
     _loadCounter();
  }


   _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(Constants.NAME);
    setState(() {
      _name = name;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ceria Jasatambang Pratama",
                  style: whiteTextFont.copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  
                  _name,
                  style: whiteTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
             
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/Profile.png',
                height: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
