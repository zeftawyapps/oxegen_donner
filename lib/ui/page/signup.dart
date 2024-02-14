import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxegen_donner/logic/lib/google.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/ui/gneralfunctions.dart';
import 'package:oxegen_donner/ui/page/login.dart';
import 'package:oxegen_donner/ui/page/register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../string.dart';
import '../value.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';

class SigneUpScreen extends StatefulWidget {
  const SigneUpScreen({Key? key}) : super(key: key);

  @override
  _SigneUpScreenState createState() => _SigneUpScreenState();
}

class _SigneUpScreenState extends State<SigneUpScreen> {
   GlobalKey<FormState> formkey =GlobalKey<FormState>();
  String? email , pass , passconf ;
  bool unconptabalpass = false ;
  UserData userData = UserData() ;
bool loading = false ;
  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>();
    return Scaffold(
        backgroundColor: bcbeg2,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bgimg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Container(
                    child:  FadeInRight(child: w()),
                  ))),
        ));
  }


  Widget w() {
    return SingleChildScrollView(
        child: Column(
      children: [
        MytextTilte(
          text: title,
        ),
        Image(width: 200, height: 200, image: AssetImage(charactterimg)),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  MytextTilteblack(text: textSignup),
                  Padding(
                    padding: const EdgeInsets.all(paddingAllTextfild),
                    child: DataTextfield(
                      textInputType: TextInputType.emailAddress,
                      hint: fieldTexthintEmail,
                      saved: (v) {email = v ; },
                      validate: (v){ if ( !isEmail(v)) {return validationEmail; }; },
                      icons: Icon(
                        Icons.email,
                        color: iconscolor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(paddingAllTextfild),
                    child: DataTextfield(


                      hint: fieldTexthintpassward,
                      saved: (v) {pass = v ; },
                      validate: ( String? v){

                         if (v!.length<8){return validationpass;

                        }},
                       ispassord: true ,
                      icons: Icon(
                        Icons.lock,
                        color: iconscolor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(paddingAllTextfild),
                    child: DataTextfield(
                      ispassord: true ,
                      hint: fieldTexthintpassordconform,
                      saved: (v) {passconf  = v ; },
                      validate: (String ? v){
                        if (v!.isEmpty){return validationpass; }
                        if (v.length<8){return validationpass;}
                      else{
                        if (unconptabalpass)return validationpassconfrom ; }
                      },


                      icons: Icon(
                        Icons.lock_open,
                        color: iconscolor,

                      ),
                    ),
                  ),
                  Mybuttons(
                      text: bottonSignupRegist, onpress: onsignup, bcg: botton , inloading:  loading ,),
                  MaterialButton(onPressed: (){
                    pushReplace(LoginScreen(), context);
                  }
                    ,child: Text(bottongotologin  ,
                      style:TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline

                      ) ,),
                  )

                 , MytextTilteblack(text: textOr),
                  MybuttonsWithImage(
                      text: '$bottonGoogleRegist', image: googlebtnimg,onpress: googleauth,fontcolr: textcolor,)
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  void onsignup(){
if (loading){return;}
    formkey.currentState!.validate();
    formkey.currentState!.save();
    setState(() {
      if (pass!= passconf){
        unconptabalpass = true;
        formkey.currentState!.validate();

          }else{
        formkey.currentState!.validate();

        unconptabalpass = false;

      }


    });
   if ( formkey.currentState!.validate()){
setState(() {
  loading  = true ;
});
     formkey.currentState!.save ();
userData.signeup(email!, pass!).then((value) async{
   if (value == 1){
     SharedPreferences sh = await  SharedPreferences.getInstance();
     sh.setString(UserData.SHAREDPREFRANCE_KEY_EMAIL,  email!);
     sh.setString(UserData.SHAREDPREFRANCE_KEY_PASSWORD,  pass!);
     sh.setInt(UserData.SHAREDPREFRANCE_KEY_STATE, UserData.SHAREDPREFREANCE_Email);

     pushReplace(RegestScreen(), context);
  }else if (value == 2 ) {
    Widget okButton = MaterialButton(
      child: Text("تسجيل الدخول" ,style: TextStyle(color: titel),),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          pushReplace(LoginScreen(), context);
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
            'البريد الالكتروني مسجل مسبقا' ),
        actions: [
          okButton,cancelButton
        ],
      );
    });

  }

});
   }

  }

  void googleauth(){
    GoogleAuth googleAuth = GoogleAuth();
    googleAuth.signInWithGoogle()
    .then((value) async {
      if (value != null) {
        Showloading() ;
        SharedPreferences sh = await  SharedPreferences.getInstance();
        sh.setInt(UserData.SHAREDPREFRANCE_KEY_STATE, UserData.SHAREDPREFREANCE_GOOGLE);


      userData.setuserdataAdded(value);
      pushReplace(RegestScreen(), context);}
    });

  }
   void Showloading(){
     showDialog(
         barrierDismissible :false ,
         context: context, builder: (contexts)
     {
       return AlertDialog(
           content: Container(
             height: 150,
             child: Column(
               children: [

                 Text(
                     'يتم تسجيل الدخول عبر جوجل ' ),
                 CircularProgressIndicator(color: titel,)
               ],
             ),
           )

       );
     });
   }
}
