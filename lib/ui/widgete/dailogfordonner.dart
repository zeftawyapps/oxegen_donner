import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:oxegen_donner/logic/module/donnertools.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';

import '../value.dart';
import 'loadsercher.dart';

class DailogofDonner extends StatefulWidget {
  const DailogofDonner({Key? key}) : super(key: key);

  @override
  _DailogofDonnerState createState() => _DailogofDonnerState();
}

class _DailogofDonnerState extends State<DailogofDonner> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool animated = false  ;
  String phone ='' ;
  String pp = '' ;
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
            width: 900,height: 300,
            decoration: BoxDecoration(
                color: Color(0xdfffffff) ,
                borderRadius: BorderRadius.circular(20)
            ),
            child:Center(child:
            Column(
              children: [
              Container(
                    width: double.infinity,
                    color: bcbeg2,

                child:   MytextTilte(text: 'تسجيل من ستتبرع له'))  ,

                 Container(
                    width: 800,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(40)),
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: formkey,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: DataTextfieldSearch(
                                textInputType: TextInputType.phone,
                                hint: 'ادخل رقم هاتف',fontsize: 11,
                                validate: (v) {},
                                saved: (v) {
                                   pp = v;
                                },
                              )),
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              onPressed: () {
                                formkey.currentState!.save();

                                setState(() {
                                        phone = pp ;
                                });
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                ,
          phone==''? Container(height: 140,
          child: Center(child :  Text('لا يوجد باحث')),
          ):     Loadsearcher(phone: phone),
SizedBox(height: 10,)
                ,

              ] ,
            )
            )),)),
    );
  }
}
