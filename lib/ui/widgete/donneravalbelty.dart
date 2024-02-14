import 'package:flutter/material.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:provider/provider.dart';

import '../value.dart';

class DonnerAvaltbalty extends StatelessWidget {
 UserData userData = UserData();
 bool isavalable = false ;
bool isloading = false ;
  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>();
    isavalable=userData.mymap[userData.isavalble.name];
    isloading = userData.isloading;
    return MaterialButton(onPressed: (){

userData.setDonnerAvalble(userData.mymap[userData.id.name],!isavalable );

    }
    ,child: isloading?CircularProgressIndicator(color: titel,):
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: isavalable?donnerisavalble:donnerisnotavalble , width: 1)
        , borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text(

                isavalable?'متاح':'غير متاح',
              style:
              TextStyle(color:isavalable?donnerisavalble:donnerisnotavalble , fontSize: 16, fontFamily: titelfomyfont),

            ),
          ),
        )
    );
  }
}
