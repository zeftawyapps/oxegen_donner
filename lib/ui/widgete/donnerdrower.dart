import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/ui/gneralfunctions.dart';
import 'package:oxegen_donner/ui/page/donner.dart';
import 'package:oxegen_donner/ui/page/useerdataediting.dart';
import 'package:oxegen_donner/ui/page/donnermovment.dart';
import 'package:oxegen_donner/ui/widgete/donneravalbelty.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../string.dart';
import '../value.dart';
import 'mywedgets.dart';
import 'package:provider/provider.dart';
class DonnerDrower extends StatelessWidget {
    DonnerDrower({Key? key}) : super(key: key);
UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>();
    return Container(width: 200,
    color: Colors.white,
    child: ListView(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(
                color: bcbeg2
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Expanded(flex: 2, child: Center(
                    child: Container(
                      width: 100,height: 100,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                          backgroundImage: AssetImage(loginimg)),
                    ),
                  )),
                  Expanded(flex: 1,
                    child:  MytextTilte(text: welcom,)  ),
                  Expanded(flex: 1,
                      child:  Mytext(text: userData.mymap[userData.name.name],)  ),
                  Expanded(flex: 1,
                      child: DonnerAvaltbalty())





                ]))

,
        MaterialButton(onPressed:   (){
          Navigator.pop(context);
          push(Details(), context);

        }
        ,child: Mytext(text: 'الاعدادات',),
        ),
        MaterialButton(onPressed:   (){
          Navigator.pop(context);
          push(DonnerMovment(), context);

        }
          ,child: Mytext(text: 'سجل التبرعات',),
        )
,  MaterialButton(onPressed:   (){
          showDialog(context: context, builder: (contexts)
          {
            Widget okButton = MaterialButton(
              child: Text("نعم" ,style: TextStyle(color: titel),),
              onPressed: ()async {
                SharedPreferences sh = await  SharedPreferences.getInstance();
                  sh.setInt(UserData.SHAREDPREFRANCE_KEY_STATE, UserData.SHAREDPREFREANCE_Non);

                SystemNavigator.pop();
              },
            );
            Widget cancelButton = MaterialButton(
              child: Text("لا",style: TextStyle(color: cancelbtn),),
              onPressed: () {
                Navigator.of(context).pop();

              },
            );

            return AlertDialog(
              content: Text(
                  '"هل تريد تسجيل الخروج من التطبيق؟' ),
              actions: [
                okButton,cancelButton
              ],
            );
          });

        }
          ,child: Mytext(text: 'تسخيل الخروج',),
        )

      ],

    ),

    );
  }
}
class DonnerDrower2 extends StatelessWidget {
  DonnerDrower2({Key? key}) : super(key: key);
  UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>();
    return Container(width: 200,
      color: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: bcbeg2
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Expanded(flex: 2, child: Center(
                      child: Container(
                        width: 100,height: 100,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(loginimg)),
                      ),
                    )),
                    Expanded(flex: 1,
                        child:  MytextTilte(text: welcom,)  ),
                    Expanded(flex: 1,
                        child:  Mytext(text: userData.mymap[userData.name.name],)  ),
                    Expanded(flex: 1,
                        child: DonnerAvaltbalty())





                  ]))

          ,
          MaterialButton(onPressed:   (){
            Navigator.pop(context);
            push(Details(), context);

          }
            ,child: Mytext(text: 'الاعدادات',),
          ),

            MaterialButton(onPressed:   (){

              pushReplace(DonnerHomeScreen(), context) ;
          }
            ,child: Mytext(text: 'عودة للرئيسية',),
          )

        ],

      ),

    );
  }
}
