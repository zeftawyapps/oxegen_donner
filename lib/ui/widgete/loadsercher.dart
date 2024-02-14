import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oxegen_donner/logic/module/donnertools.dart';
import 'package:oxegen_donner/logic/module/movment.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:flutter/material.dart';
import 'package:oxegen_donner/ui/gneralfunctions.dart';
import 'package:oxegen_donner/ui/icons/person_icons.dart';
import 'package:oxegen_donner/ui/page/donnermovment.dart';
import 'package:provider/provider.dart';

import '../value.dart';
class Loadsearcher extends StatefulWidget {
  String phone ;
  Loadsearcher({Key? key,required this.phone }) : super(key: key);


  @override
  _LoadsearcherState createState() => _LoadsearcherState();
}

class _LoadsearcherState extends State<Loadsearcher> {
 UserData userData =UserData() ;
 DonnerToolsprovider dotprov = DonnerToolsprovider();
 Movment movment = Movment() ;
 bool loading = false ;
  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>() ;
    dotprov =context.watch<DonnerToolsprovider>();
    movment = context.watch<Movment>() ;
    return FutureBuilder<QuerySnapshot>(
        future: userData.loadSearcher(widget.phone),

        builder: (c, s ){
          List<Map<String, dynamic>> _getlist = <Map<String, dynamic>>[];
          _getlist = userData.getDataasopject(s.data!,idcell: userData.id.name);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical:10),
            child: Container(

              height: 100,
              child:loading?Container(child: Center(child: CircularProgressIndicator(color: titel,)),): ListView.builder(
                  shrinkWrap: true,
                  itemCount: _getlist.length,
                  itemBuilder: (c,i){
                return MaterialButton(
                  onPressed: (){
setState(() {
  loading = true ;
});
movment.addMovement(userData.mymap[userData.id.name],


     {movment.name.name:_getlist [i][userData.name.name] ,
       movment.Date.name : DateTime.now().millisecondsSinceEpoch,
       movment.searcherid.name:_getlist [i][userData.id.name] ,
       movment.tools.name :   dotprov.donnertoolsString()
     }) .then((value) {

       pushReplace(DonnerMovment(), context) ;

});
                  },
                  child: Card (
                    child: Row (children: [
                      Icon( Person.user,
                        color: iconscolor,),SizedBox(width: 5,)
                    ,  Text(_getlist [i][userData.name.name],)
                    ],),
                  ),
                ) ;
              }),
            ),
          );});
  }
}
