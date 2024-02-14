import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/ui/icons/person_icons.dart';
import 'package:oxegen_donner/ui/icons/whatsapp_icons.dart';
import 'package:oxegen_donner/ui/page/fivorate.dart';
import 'package:oxegen_donner/ui/widgete/donnerdrower.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';
import 'package:oxegen_donner/ui/widgete/searchermap.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oxegen_donner/logic/module/map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


import '../string.dart';
import '../value.dart';
import 'useerdataediting.dart';


class Searcher extends StatefulWidget {
  @override
  State<Searcher> createState() => SearcherState();
}

class SearcherState extends State<Searcher> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {


  
    return    Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
key:  key ,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,),
        body:WillPopScope(

           onWillPop:  _onWillPop,
            child: screans(_selectedIndex))
      
        ,
        bottomNavigationBar:   BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Person.user),
              label: searchermyfile,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '$searcherHome',
            ),

            BottomNavigationBarItem(

              icon: Icon(Icons.star),
              label: searcherfevor,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: titel,
          onTap: _onItemTapped,
        ),

      ),
    );;
  }

Widget screans(int i ){
 switch (i){
   case 0 :
     return FadeInRight(child: Details());
   case 1:
   return   FadeIn(child: SearcherMap());

 }
 return   FadeInLeft(child:FevorateScreen());
}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  Future<bool> _onWillPop() async {
    return (
        await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('هل انت تريد ان '),

        actions: <Widget>[
          TextButton(
            onPressed: ()async {
              SharedPreferences sh = await  SharedPreferences.getInstance();
              sh.setInt(UserData.SHAREDPREFRANCE_KEY_STATE, UserData.SHAREDPREFREANCE_Non);

              SystemNavigator.pop();
            },
            child: new Text('تسجيل خروج'),
          ),
          TextButton(
            onPressed: (){SystemNavigator.pop();},
            child: new Text('اغلاق التطبيق ' , style: TextStyle(color: titel)),
          ),

          TextButton(
            onPressed: () {Navigator.pop(context); },

            child: new Text('الغاء ',style: TextStyle(color: cancelbtn)),
          ),

        ],
      ),
    )) ?? false;
  }

}