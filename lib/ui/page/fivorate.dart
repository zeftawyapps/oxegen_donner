import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/ui/icons/whatsapp_icons.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../string.dart';
import '../value.dart';
class FevorateScreen extends StatefulWidget {
  const FevorateScreen({Key? key}) : super(key: key);

  @override
  _FevorateScreenState createState() => _FevorateScreenState();
}

class _FevorateScreenState extends State<FevorateScreen> {
  UserData userdata = UserData() ;
  bool removing = false ;
  @override
  Widget build(BuildContext context) {
    userdata = context.watch<UserData>();
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),

        ),
      body: FutureBuilder<QuerySnapshot>(
      future: userdata.getDonnerFavorate(),

          builder: (context ,snap ){
            List<Map<String, dynamic>> _getlist = <Map<String, dynamic>>[];
            _getlist = userdata.getDataasfevorate(snap.data!,idcell: userdata.id.name);

            return Container(
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

                         Expanded(child: MytextTilte( text:searcherfevor,)),
                  Expanded(flex: 1, child:  Image(  image: AssetImage('$favorateeimg')))
                    ,

              ],),
                     )),
               );
                   }
             String  isv = _getlist[i-1][userdata.name.name] ;
             return MaterialButton(
               onPressed: (){
                 userdata.setDatapase(_getlist[i-1]); 
                 modalBottomSheetMenu(c);
               },
               child: FadeOutLeft(

                 animate:  _getlist[i-1]['r'],
                 child: Padding(
                   padding: const EdgeInsets.all(3),
                   child: Row (
                     children: [
                     Expanded(flex: 1,
                       child: CircleAvatar(
                       backgroundColor:titel,
                       child: Container(
                         width: 70,
                         child: Center(
                           child: Text(isv.substring(0,1) ,style: TextStyle(
                               color: Colors.white
                           ),),
                         ),
                       ),
                   ),
                     )
                     , Expanded(
                           flex: 3,
                           child: Text(isv,style:   TextStyle(color: textcolor, fontSize: 16, fontFamily: titelfomyfont),
                               ),     ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                         onPressed: (){
                           setState(() {
                             _getlist[i-1]['r']=true;
                           });
                           userdata.removeFivorate(userdata.mymap[userdata.id.name],
                               _getlist[i-1][userdata.id.name]
                           ).then((value) {setState(() {

                           });});
                         },
                         child: Container(color: delete,
                         width: 50,height: 50,
                         child: Center(child: Icon(Icons.delete,color: Colors.white,)),),
                       ),
                    )],
                     ),
                 ),
               ),
             );


           }),
         );
       },
      ),
    );
  }

  void modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (builder) {
          return StatefulBuilder(builder: (context, stat) {
            bool isavalble = userdata.passmap[userdata.isavalble.name];
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                    height: 350.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: MytextTilte(
                              text: '${userdata.passmap[userdata.name.name]}',
                            )),
                        Expanded(
                            child: Mytext(
                                text:
                                '${userdata.passmap[userdata.city.name]}')),
                        Expanded(
                            child: Mytext(
                                text:
                                '${userdata.passmap[userdata.address.name]}')),
                        Expanded(
                            child: Text(
                              isavalble ? 'متاح' : 'غير متاح',
                              style: TextStyle(
                                  color: isavalble
                                      ? donnerisavalble
                                      : donnerisnotavalble,
                                  fontSize: 16,
                                  fontFamily: titelfomyfont),
                            )),
                        // Expanded(
                        //     child: Container(
                        //         child: Center(
                        //             child: MytextTilteblack(
                        //   text: texthContactus,
                        // )))),
                        Expanded(
                            child: Mytext(
                              text: texthintphone,
                            )),
                        Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                launch(
                                    "tel://${userdata.passmap[userdata.phone.name]}");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: bcbeg2,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: botton,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(30),
                                                  bottomRight:
                                                  Radius.circular(30))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                            Icon(Icons.phone, color: fontbtn),
                                          )),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                          '${userdata.passmap[userdata.phone.name]}')
                                    ]),
                              ),
                            )),
                        Expanded(
                            child: Mytext(
                              text: texthintwhatsappPhne,
                            )),
                        Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                 String s =
                                    "https://wa.me/+2${userdata.passmap[userdata.whatsphone.name]} ?text=$txtmsgwhats";

                                launch(s);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: bcbeg2,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: botton,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(30),
                                                  bottomRight:
                                                  Radius.circular(30))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                                Whatsapp.iconmonstr_whatsapp_1,
                                                color: fontbtn),
                                          )),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '${userdata.passmap[userdata.whatsphone.name]}'),
                                      )
                                    ]),
                              ),
                            )),

                      ],
                    )),
              ),
            );
          });
        });
  }

}
