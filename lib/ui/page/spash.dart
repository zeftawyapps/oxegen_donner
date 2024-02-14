import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oxegen_donner/logic/lib/google.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/ui/string.dart';
import 'package:oxegen_donner/ui/value.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../gneralfunctions.dart';
import 'login.dart';
import 'signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visblde = false;
  bool visblde2 = false;
  Timer? timer;
  int senario = 0;
  int secondes = 1500;
  UserData userData = UserData();
 late  SharedPreferences sh ;
 int state =0;
 String email = '';
 String pass = '';
  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>();
    timer = Timer.periodic(Duration(milliseconds: secondes), (timer)async {

      sh = await SharedPreferences.getInstance();
       if ( sh.getInt(UserData.SHAREDPREFRANCE_KEY_STATE)!= null ) {
      state = sh.getInt(UserData.SHAREDPREFRANCE_KEY_STATE)!;
  // state = 0 ;
           switch (state) {
             case UserData.SHAREDPREFREANCE_Non :
               setnewloading(timer);
               break;
             case UserData.SHAREDPREFREANCE_GOOGLE :
               googleauth();
               break;
             case UserData.SHAREDPREFREANCE_Email :
               onsignup();
               break;
           }

       }else{
         sh = await SharedPreferences.getInstance();
       sh.setInt(UserData.SHAREDPREFRANCE_KEY_STATE, UserData.SHAREDPREFREANCE_Non);
       }

    } );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: bcbeg),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(width: 200, height: 200, image: AssetImage(logodir)),
              MytextTilte(text: '$title'),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                height: visblde ? 120 : 0,
                child: FadeInRight(
                  animate: visblde2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Mytext(text: '$describetion'),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                height: visblde ? 60 : 0,
              ),
              FadeInUp(
                  duration: Duration(milliseconds: 600),
                  animate: visblde2,
                  child: Mybuttons(text: bottonLogin,onpress: (){
                    pushReplace(LoginScreen() , context) ;

                  },bcg: botton2 ,)),
              FadeInUp(
                  animate: visblde2,
                  child: Mybuttons(text: bottonSignup,onpress: (){

                    pushReplace(SigneUpScreen() , context);
                  },bcg: botton  ),  ),
              Container(
                child: loading?CircularProgressIndicator(color: botton,):
                Container()
                ,
              )
            ],
          ),
        ),
      ),
    );
  }
bool loading = false ;
  void onsignup(){

    if (loading){return;}
        setState(() {
        loading  = true ;
      });

       userData.login(sh.getString(UserData.SHAREDPREFRANCE_KEY_EMAIL)!, sh.getString(UserData.SHAREDPREFRANCE_KEY_PASSWORD)! ).then((value)async {
        if (value == 1){

          userData .    pushbyState(  context );}
        if (userData.reopenloctioan){
          setState(() {
            userData.setropnloact() ;
          });
        }
        else if (value == 2 ) {
          Widget okButton = MaterialButton(
            child: Text("تسجيل جديد " ,style: TextStyle(color: titel),),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {

                pushReplace(SigneUpScreen(), context);
              });
            },
          );
          Widget cancelButton = MaterialButton(
            child: Text("العاء",style: TextStyle(color: cancelbtn),),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                loading = false ;
              });
            },
          );
          showDialog(context: context, builder: (contexts)
          {
            return AlertDialog(
              content: Text(
                  'البريد الالكتروني ليس مسجل ' ),
              actions: [
                okButton,cancelButton
              ],
            );
          });


        }});
    }


  void googleauth(){
    if(loading ){return; }

    setState(() {
      loading = true ;
    });

    GoogleAuth googleAuth = GoogleAuth();

    googleAuth.signInWithGoogle()
        .then((value) async{
      if (value != null){

        userData.setuserdata(value);
        userData.pushbyState(  context );}

    });

  }
  void setnewloading(Timer timer){
  if(loading ){return; }
  setState(() {

    senario++;

    if (senario == 2) {
      visblde2 = true;
      timer.cancel();
    } else if (senario == 1) {

      visblde = true;

    }
  });
}
  }

