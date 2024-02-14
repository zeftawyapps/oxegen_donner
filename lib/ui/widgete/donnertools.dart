
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oxegen_donner/logic/lib/modulscreateor.dart';
import 'package:oxegen_donner/logic/module/donnertools.dart';
import 'package:oxegen_donner/ui/widgete/dailogfordonner.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';
import 'package:provider/provider.dart';
import '../value.dart';
import 'donnerpanner.dart';
import 'textquant.dart';
class DonnerTools extends StatefulWidget {
  const DonnerTools({Key? key}) : super(key: key);

  @override
  _DonnerToolsState createState() => _DonnerToolsState();
}

class _DonnerToolsState extends State<DonnerTools> {
  DonnerToolsprovider dotprov = DonnerToolsprovider();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool ischosed = false ;
  int lingeths = 0 ;
  bool donnerenterd = false ;
  @override
  Widget build(BuildContext context) {
    dotprov =context.watch<DonnerToolsprovider>();
    dotprov.addDataDonnter();
  lingeths = dotprov.toolschosed.length;
    return ListView(

        children: [
          Donnerpanner(),
          Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20, top: 10, bottom: 10),
          child: Container(
              width: double.infinity,
              color: bcbeg2,

              child: MytextTilte(text: 'إضافة تبرع جديد ')),
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                onPressed: (){
                  savedonner();
                  modalBottomSheetMenu(context,'انابيب');

                },
                child: Container(child: Row(children: [MytextTilteblack(text: 'انابيب')],))),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: MaterialButton(
                onPressed: (){
                  savedonner();
                  modalBottomSheetMenu(context,'مولد'); },
                child: Container(child: Row(children: [MytextTilteblack(text: 'مولد')],))),
          )
          , Padding(
            padding: const EdgeInsets.all(12.0),
            child: MaterialButton(
                onPressed: (){
                  savedonner();
                  modalBottomSheetMenu(context,'اسطوانة');},
                child: Container(child: Row(children: [MytextTilteblack(text: 'اسطوانة')],))),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 10, bottom: 10),
            child: Container(
                width: double.infinity,
                color: bcbeg2,

                child:  dotprov.toolschosed.length!=0 ? MytextTilte(text: 'ادخل الكمية '):Container()),
          ),
         Form(
           key: formkey ,
           child: ListView.builder(
               shrinkWrap: true,
                itemCount: dotprov.toolschosed.length,
               itemBuilder: (c ,i ){

                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(child: Row(children: [
                     Expanded(
                         flex: 1,
                         child: Text(   dotprov.toolschosed[i][DonnerToolsData.name().maindepart.name],
                           style: TextStyle(
                               color: textcolor,
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               fontFamily: titelfomyfont),
                         ))

                     , Expanded(
                         flex: 2,
                         child: Text(  dotprov.toolschosed[i][DonnerToolsData.name().partdep.name],
                           textAlign: TextAlign.start,
                           style:
                           TextStyle(color: textcolor, fontSize: 16, fontFamily: titelfomyfont),

                         ))
                    , Expanded(
                       flex: 1,
                      child: DataTextfieldQuantity(
                         textInputType: TextInputType.number,

                         saved: (v) {

                           dotprov.setquntity(i, DonnerToolsData.name().qunat.name, v);

                         },
                         validate: (String? v) {

                         },
mainvalue:  dotprov.toolschosed[i][DonnerToolsData.name().qunat.name].toString(),
                       ),
                    )
                   ],) ,),
                 );
               }),
         ),
          Container(
              child:donnerenterd  ?
              DailogofDonner()
                  :Container()),
 Container(
   child:lingeths !=0   ? Visibility(
     visible: !donnerenterd,
     child: Mybuttons(text:  'ادخل الكمية', bcg: botton ,

     onpress: (){setState(() {
       donnerenterd = true ;
     });}
     ),
   ):Container(),


 )
          ,

        ] );
  }

void sendDonner(){
 savedonner() ;
  showdialogeOfDonner(context) ;
}

void savedonner (){
    if (dotprov.toolschosed.length ==0){return ; }
  formkey.currentState!.save();
  print(dotprov.toolschosed);
}
  void modalBottomSheetMenu(BuildContext context,String where){
 //   dotprov.addDataDonnter();
    List<Map<String , dynamic >> newdata=[];
    newdata = dotprov.loadwhere(where);
int l = newdata.length;
double tall = 50  ;
switch(l){
  case 1: tall = 50 ;  break ;
  case 2:tall =100;  break ;
  case 3:tall =150 ;  break ;
}

    showModalBottomSheet(
        context: context,
        shape:  RoundedRectangleBorder(
          borderRadius:  BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (builder){
          return  Container(
              height: tall,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0))
              ),
              child:  Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: ListView.builder(
                      itemCount: newdata.length,
                      itemBuilder:(context , i ){

                    return MaterialButton(
                      onPressed: (){

                        dotprov.addtheTallsChossed(newdata[i]);
                        setState(() {
                          ischosed = true;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text (  newdata[i][DonnerToolsData.name().partdep.name]
                        ,  textAlign: TextAlign.start,
                          style: TextStyle(
                              color: textcolor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: titelfomyfont),

                        ),
                      ),
                    );
                  }) ,
                ),
              ));
        }
    );
  }
  void showdialogeOfDonner(BuildContext context){

    showDialog(
        barrierDismissible: false ,
        context: context, builder: (context){

      return DailogofDonner() ;
    });
  }

}