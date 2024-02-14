

import 'package:flutter/cupertino.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/logic/values.dart';

import 'page/donner.dart';
import 'page/register.dart';
import 'page/searcher.dart';

bool isEmail(String em) {

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
// void pushbyState(UserData userData,BuildContext context , String uid ){
//
//   userData. getSingleData(COLLECTION_USER_DATA, uid  )
//       .then((value) {
//      int v = value![userData.id.name];
//       switch (v) {
//         case 0 :
//           pushReplace(RegestScreen(), context);
//           break;
//         case UserData.USER_STATE_DONNER :
//           pushReplace(DonnerHomeScreen(), context);
//           break;
//         case UserData.USER_STATE_SEARCHER :
//           pushReplace(SearcherHomeScreen(), context);
//
//           break;
//       }
//      });
//
//
//
//   }

pushReplace(Widget w ,BuildContext context ){
  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>w ));

  Navigator.of(context).pushReplacement(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => w,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.linear;

      var tween =
      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ));
}
push(Widget w ,BuildContext context ){
  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>w ));

  Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => w,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.linear;

      var tween =
      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ));
}
