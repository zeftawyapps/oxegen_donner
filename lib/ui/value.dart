import 'package:flutter/material.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

String imgdir = 'assite/img/';
String logo ='logo.png';
String loging ='logo.png';
String bg ='bg.png';
String google='googlebtn.png';
String vector ='vector.png';
String profile ='profile.png';
String favorate ='rt.png';
String movment ='ch.png';
String charactter = 'charachter.png';
String titlefont = 'assite/font/myfont.ttf';
String titelfomyfont = 'Schyler';



 String logodir='$imgdir$logo';
String loginimg='$imgdir$loging';
String bgimg='$imgdir$bg';
String charactterimg='$imgdir$charactter';
String googlebtnimg='$imgdir$google';
String profileimg='$imgdir$profile';
String favorateeimg='$imgdir$favorate';
String vectorimg='$imgdir$vector';
String movmentimg='$imgdir$movment';



var backgroungride =
LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    bcbeg,
    bcbeg2
  ],);
const double paddingAllTextfild = 12 ;

final key = new GlobalKey<ScaffoldState>();

Color bcbeg = Color(0xFFe6f4ed);
Color bcbeg2 = Color(0xFFe6f4ed);
Color fontbtn = Color(0xffd0e9d3);
Color fontbtn2 = Color(0xffe9d0d0);

Color botton = Color(0xff1e8d32);
Color botton2 = Color(0xfffbc355);
Color titel = Color (0xf9006f10);
Color textf = Color(0xffe4f3eb);
Color hintcolor = Color(0xff868e8f);
Color iconscolor = Color (0xff268168);
Color textcolor = Color(0xff353535);
Color cancelbtn = Color (0xf96f0000);
Color delete = Color (0xf9ff3f5d);
Color donnerisavalble = Color (0xf9024b0e);
Color donnerisnotavalble = Color (0xf9590101);

 //
// String getdate(DateTime date){
//   return  DateTimeFormatter().yMMMd().format(date); // Apr 8, 2020
//
// }
