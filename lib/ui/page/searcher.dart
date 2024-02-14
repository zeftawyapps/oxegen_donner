import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';

import '../value.dart';
import 'searchmap.dart';
class SearcherHomeScreen extends StatefulWidget {
  const SearcherHomeScreen({Key? key}) : super(key: key);

  @override
  _SearcherHomeScreenState createState() => _SearcherHomeScreenState();
}

class _SearcherHomeScreenState extends State<SearcherHomeScreen> {
  loc.Location location = loc.Location();//explicit reference to the Location class

  Future<bool> _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
      return false ;
    }else {return true ;}}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<bool>(
        future: _checkGps(),
        builder: (context , v){
          if (!v.data!){
           return Container(child: Center(
             child: Mybuttons(onpress: (){
               setState(() {

               });
             },text: 'تم فتح ال gps ', bcg: botton ,),
           ),);
          }else{
          return Container(

          child: Searcher(),
          ); }

        },
      ));


  }
}
