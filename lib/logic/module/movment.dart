
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocode/geocode.dart';
import 'package:oxegen_donner/logic/lib/firebase.dart';
import 'package:oxegen_donner/logic/lib/modulscreateor.dart';
import 'package:oxegen_donner/ui/gneralfunctions.dart';
import 'package:oxegen_donner/ui/page/donner.dart';
import 'package:oxegen_donner/ui/page/register.dart';
import 'package:oxegen_donner/ui/page/searcher.dart';
import 'package:provider/provider.dart';

import '../values.dart';
import '../values.dart';
class Movment  extends ChangeNotifier with FirebaseHelper{
Cell name = Cell('name');
Cell id = Cell('id');
Cell Date = Cell('date');
Cell tools = Cell ('tools');
Cell searcherid = Cell('searcherid');


String setmovementcollection(String uid) {
  return '$COLLECTION_USER_DATA/$uid/$COLLECTION_Movement_DATA';
}

Future  addMovement(String uid, Map<String, dynamic>map) {
 return  addDataCloudFirestore(collection: setmovementcollection(uid), mymap: map);
}

Future <void> removeMovemant(String uid, String fivoid) {
  return deleteDataCloudFirestore(
      collection: setmovementcollection(uid), id: fivoid);
}

List<Map<String, dynamic>> getDataasMovment(QuerySnapshot snapshot,
    { String? idcell }) {
  List<Map<String, dynamic>> getlist = <Map<String, dynamic>>[];

  QuerySnapshot qs = snapshot;
  qs.docs.map((doc) {
    Map<String, dynamic> docmap = Map();
    docmap = doc.data()! as Map<String, dynamic>;
    if (idcell != null) {
      docmap.addAll({idcell: doc.id});
    }
    docmap.addAll({'r': false});
    getlist.add(docmap);
  }).toList();

  return getlist;
}

}