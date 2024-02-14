
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseHelper{

  String dawenlaodUri = "";
  String _filename = '';
  String _directory = '';
String filepath = '';
String ERROR_EmailNot_Found = 'There is no user record corresponding to this identifier. The user may have been deleted.';
 String ERROR_SAME_EMAIL_SIGNEDUP = 'The email address is already in use by another account.';
   Future  UploadDataStoreage(File file , {String? dir , String? filename  } )async{
  if (dir == null){
    dir = 'Z_Apps' ;
  }else {_directory = dir ; }
  if (filename == null){
    filename = DateTime.now().millisecondsSinceEpoch.toString() ;
_filename = filename ;
  }else {_filename = filename ; }

  String  name = file.path.split("/").last;
  String  extantion = name.split('.').last ;
_filename ='$_filename.$extantion';
filepath =   '$_directory/$_filename';
  try {
   return    await firebase_storage.FirebaseStorage.instance
          .ref('$filepath' )
          .putFile(file);
    } on  FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
     }

  Future<DocumentReference> addDataCloudFirestoreWithoutid ({required String collection,   required Map<String, dynamic> mymap}) async {

      CollectionReference firebaseCollection  ;
      firebaseCollection = FirebaseFirestore.instance.collection(collection);
      return   firebaseCollection.add(mymap);


    }


  Future <void> editDataCloudFirestore({required String collection,  required String id, required Map<String, dynamic> mymap}) async {


    CollectionReference firebaseCollection  ;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return   firebaseCollection.doc(id).update(mymap);

  }
  Future <void> deleteDataCloudFirestore({required String collection,  required String id }) async {


    CollectionReference firebaseCollection  ;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return   firebaseCollection.doc(id).delete();

  }


CollectionReference getCollrection(String collection){
     return
      FirebaseFirestore.instance.collection(collection);

}
  Future addDataCloudFirestore({required String collection,  String? id, required Map<String, dynamic> mymap}) async {
    if (id==null){
      CollectionReference firebaseCollection  ;
      firebaseCollection = FirebaseFirestore.instance.collection(collection);
      return   firebaseCollection.add(mymap);

    }else{

      CollectionReference firebaseCollection  ;
      firebaseCollection = FirebaseFirestore.instance.collection(collection);
      return   firebaseCollection.doc(id).set(mymap);

    }
   

    
  }
  Future<String > downloadURLStoreage( ) async {
   return  await firebase_storage.FirebaseStorage.instance
        .ref(filepath)
        .getDownloadURL();


  }
  Future<UserCredential> loginWith(String email , String pass  ){

    FirebaseAuth auth = FirebaseAuth.instance;
    return   auth.signInWithEmailAndPassword(email: email, password: pass);

  }
  Future<UserCredential> createNewAccount(  String email , String pass  )  async {

    FirebaseAuth auth = FirebaseAuth.instance;
    return  auth.createUserWithEmailAndPassword(email: email, password: pass) ;
  }

  List<Map<String  , dynamic>> getlist  =   <Map<String  , dynamic>>[];

  Future <QuerySnapshot > laodData1(String collection )async{

    CollectionReference firebaseCollection;
    firebaseCollection =
        FirebaseFirestore.instance.collection(collection);
    return await  firebaseCollection. get() ;
  }


  List<Map<String, dynamic>> getData(AsyncSnapshot<QuerySnapshot<Map<String  , dynamic>>> snapshot) {
    List<Map<String, dynamic>> getlist =   <Map<String, dynamic>>[]  ;
    QuerySnapshot qs = snapshot.data!;
    qs.docs.map((doc ){
      getlist.add( doc.data()!as Map<String,dynamic>);

    }).toList();

    return getlist ;
  }


List<Map<String, dynamic>> getDataasopject( QuerySnapshot  snapshot,{ String?  idcell } ) {
    List<Map<String, dynamic>> getlist =   <Map<String, dynamic>>[]  ;

    QuerySnapshot qs = snapshot;
    qs.docs.map((doc ){
      Map<String  , dynamic>   docmap  = Map();
docmap = doc.data()!as Map<String,dynamic>;
      if (idcell!=null){
        docmap.addAll({idcell: doc .id}); }
      getlist.add( docmap);

    }).toList();

    return getlist ;
  }


  Future  <Map<String , dynamic>?>  getSingleData(String collectin , String  id )async {

    CollectionReference firebaseCollection;
    firebaseCollection =
        FirebaseFirestore.instance.collection(collectin);
    DocumentSnapshot doc = await firebaseCollection.doc(id).get();


    return doc.data() as Map<String,dynamic>;
  }





}