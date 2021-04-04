import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tunas_honda_absensi/string_util.dart'
    as Util;

import '../../../../constants.dart';

class DateTimeWidget extends StatefulWidget {
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  String date = Util.StringUtil.hourMinuteNow();
  String completeDateTimeNow = Util.StringUtil.completeDateTimeNow();

  void _getCurrentTime() {
    if (!mounted) return;
    setState(() {
      Util.StringUtil.hourMinuteNow();
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Center(
            child: new Text(
              Util.StringUtil.hourMinuteNow(),
              style: whiteTextFont.copyWith(
                  fontSize: 50, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Text(
          Util.StringUtil.completeDateNow(),
          style: whiteTextFont.copyWith(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
