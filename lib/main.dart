

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oxegen_donner/logic/lib/firebase.dart';
import 'package:oxegen_donner/logic/module/donnertools.dart';
import 'package:oxegen_donner/logic/module/map.dart';
import 'package:oxegen_donner/logic/module/movment.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/logic/provider/project.dart';
import 'package:oxegen_donner/ui/page/map.dart';
import 'package:oxegen_donner/ui/page/spash.dart';
import 'package:provider/provider.dart';

import 'ui/page/register.dart';
import 'ui/value.dart';
import 'ui/value.dart';

void main() {
  // ErrorWidget.builder = (FlutterErrorDetails details) => Container(child: Center(child: CircularProgressIndicator(
  //
  //
  //   color: titel ,
  // ),),);


  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown , DeviceOrientation.portraitUp]).then((_){
    Firebase.initializeApp();
    runApp(MyApp());});
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (c)=>UserData()),
        ChangeNotifierProvider(create: (c)=>ProjectProvider()),
        ChangeNotifierProvider(create: (c)=>MapData()),
        ChangeNotifierProvider(create: (c)=>DonnerToolsprovider()),
        ChangeNotifierProvider(create: (c)=>Movment()),
      ],
      child:  MaterialApp(
          debugShowCheckedModeBanner: false ,

          title: 'Oxgen',
          theme: ThemeData(


          ),
          home:  SplashScreen()
      ),
      );

  }
}
class myapptest extends StatelessWidget {
  const myapptest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: MaterialButton(
              onPressed: (){
                FirebaseHelper firebaseHelper =FirebaseHelper();
                firebaseHelper.addDataCloudFirestore(collection: 'text', mymap: {
                'test':'tt'}
                );
              },
              child: Text('test'),
            ),
          ),
        ),
      ),
    );
  }
}

