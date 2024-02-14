import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getdate(DateTime date){
  return  DateFormat.yMMMd().format(date); // Apr 8, 2020

}

String getdatefromellesecont(int  seconts){
  DateTime Datetimes =
  DateTime.fromMicrosecondsSinceEpoch(seconts * 1000);

  return  DateFormat.yMMMd().format(Datetimes); // Apr 8, 2020

}