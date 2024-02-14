import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oxegen_donner/logic/lib/fuctions.dart';
import 'package:oxegen_donner/logic/module/movment.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/ui/icons/person_icons.dart';
import 'package:oxegen_donner/ui/widgete/donnerdrower.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';
import 'package:provider/provider.dart';

import '../string.dart';
import '../value.dart';
class DonnerMovment extends StatefulWidget {
  const DonnerMovment({Key? key}) : super(key: key);

  @override
  _DonnerMovmentState createState() => _DonnerMovmentState();
}

class _DonnerMovmentState extends State<DonnerMovment> {
  UserData userdata = UserData() ;
  bool removing = false ;
  Movment movment = Movment();
  @override
  Widget build(BuildContext context) {
    userdata = context.watch<UserData>();
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),

        ),
        drawer: DonnerDrower2(),
        body: FutureBuilder<QuerySnapshot>(
          future: userdata.getDonnerMovment(),

          builder: (context ,snap ){
            List<Map<String, dynamic>> _getlist = <Map<String, dynamic>>[];
            _getlist = userdata.getDataasMovment(snap.data!,idcell: userdata.id.name);

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                child: ListView.builder(
                    itemCount: _getlist.length+1,
                    itemBuilder: (c,i){
                      if (i==0){
                        return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: bcbeg2
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(children: [

                                  Expanded(child: MytextTilte( text:donnermovment,)),

                                  Expanded(flex: 1, child:  Image(  image: AssetImage('$movmentimg')))
                                  ,
                                     ],),
                              )),
                        );
                      }
                      String  isv = _getlist[i-1][movment.name.name] ;
                      String tools = _getlist[i-1][movment.tools.name] ;
                      String date = getdatefromellesecont( _getlist[i-1][movment.Date.name]) ;
                return ListTile(
                  title: Text(date),
                  subtitle: ListTile(
                    leading:  CircleAvatar(
                                                backgroundColor:titel,
                                                child: Container(
                                                  width: 70,
                                                  child: Center(
                                                    child:  Icon( Person.user,
                                                      color: Colors.white,) ,
                                                  ),
                                                ),
                  )
                  ,
                     title: Text(isv,style:   TextStyle(color: textcolor, fontSize: 16, fontFamily: titelfomyfont),)
                  ,subtitle: Text(tools,style:   TextStyle(color: textcolor, fontSize: 15, fontFamily: titelfomyfont),)

                  ),
                );



                    }),
              ),
            );
          },
        ),
      ),
    );
  }

}
