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
import 'package:location/location.dart' as loc;

import '../values.dart';
class UserData extends ChangeNotifier with FirebaseHelper {
  Cell id = Cell('uid');
  Cell email = Cell('email');
  Cell name = Cell('name');
  Cell phone = Cell('phone');
  Cell whatsphone = Cell('whatsphone');
  Cell age  = Cell('age');
  Cell address = Cell('address');
  Cell city = Cell('city');
  Cell loction = Cell('loction');
  Cell long = Cell('long');
  Cell late = Cell('late');
  Cell state = Cell('state');
  Cell isavalble = Cell('isavalble');
  Cell keywords = Cell('keywords');
String fivorate='Fivorate';
bool isloading = false  ;
 static const   int USER_STATE_DONNER = 1;
    static const   int USER_STATE_SEARCHER = 2;
  Map<String , dynamic> usermap = Map<String , dynamic>();
  Map<String , dynamic> mymap = Map<String , dynamic>();
  Map<String , dynamic> myLocationDatamap = Map<String , dynamic>();
  Map<String , dynamic> passmap =Map<String , dynamic>() ;
  void setDatapase(Map<String , dynamic> passmapd ){
    passmap = passmapd ;
    notifyListeners();
  }
  Future<int >  signeup(String email , String pass )async{
 try {
   int sta = 0;
   UserCredential uc  =  await  createNewAccount(email, pass);
   if (uc.user!.email != null){sta = 1 ; }
   if (uc.user == null ){sta = 0 ; }
   mymap={this.email.name : uc.user!.email , this.id.name : uc.user!.uid};
   notifyListeners();
   return sta ;
 } on Exception catch ( e) {
   // TODO
   if (e.toString().contains(ERROR_SAME_EMAIL_SIGNEDUP) ){
     return 2 ;
   }
   return 0 ;
 }

}
bool reopenloctioan = false ;
  setropnloact(){
    reopenloctioan = false;
  }
void setLocationmap (double lat , double long , String city , String address ){
    myLocationDatamap ={late.name : lat ,this.  long.name:long
    , this.city.name : city , this.address.name : address
    };
    notifyListeners() ;
}

  Future<int >  login(String email , String pass )async{
    try {
      int sta = 0;
      UserCredential uc  =  await  loginWith(email, pass);
      if (uc.user!.email != null){sta = 1 ;
      mymap={this.email.name : uc.user!.email , this.id.name : uc.user!.uid};
      notifyListeners();
      }
      if (uc.user == null ){sta = 0 ; }

      return sta ;
    } on Exception catch (e) {
      // TODO
      if (e.toString().contains(ERROR_EmailNot_Found)){
        return 2 ;
      }
      return 0 ;
    }

  }
  void setuserdataAdded( User user){
    mymap={this.email.name :  user.email , this.id.name :  user.uid};

    addDataCloudFirestore(collection: COLLECTION_USER_DATA, mymap:mymap ,id:user.  uid )
        .then((value) { notifyListeners();})
    ;

    notifyListeners();
  }

  void setlaoding (bool l ){
  isloading  =l ;
  notifyListeners();
}
  void setuserdata ( User user){
    mymap={this.email.name :  user.email , this.id.name :  user.uid};



    notifyListeners();
  }
void setDonnerAvalble(String id , bool isava){
 if (isloading){return ; }
  setlaoding(true);
  editDataCloudFirestore(collection: COLLECTION_USER_DATA, mymap: {isavalble.name:isava},id: id)
  .then((value) {
    getSingleData(COLLECTION_USER_DATA,id  ).then((value) {
      mymap = value!;
      mymap.addAll({this.id.name:id });
      isloading  =false  ;
      notifyListeners();
    });
  });
}
Future  addDataDonner(String id,String email  ,{required  String name, required String phone,

  required String whats,
required String address , required  String city  ,  required double long   ,
   required double late,required bool isnew  }) {
  final coordinates = GeoCode();
  List<String > keys =[];
   List<String >names = name.split(" ");

String  c =   myLocationDatamap[this. city.name];
String a =    myLocationDatamap[this. address.name];
   keys = [id , email ,

c , a ,
     phone ,    whats ,  phone , whats , city , address , late.toString() , long.toString()

     ,
    ] ;
   keys.addAll(names);


mymap = {

  this.email.name :email ,   this.name.name: name, this.state.name : USER_STATE_DONNER
  ,  this.phone.name : phone , this.whatsphone.name: whats ,isavalble.name : false ,
  this.address.name:address , this.city.name:city , this.late.name:late , this.long.name :long
  ,this.keywords.name:keys,this.id.name : id  };

  usermap = mymap;
  notifyListeners();
if (isnew ) {
  return addDataCloudFirestore(
      collection: COLLECTION_USER_DATA, mymap: mymap, id: id);
}else {
  return editDataCloudFirestore(
      collection: COLLECTION_USER_DATA, mymap: mymap, id: id);
}

  }

  void  setDataDonnermap(String id,String email  ,{

    required  String name, required String phone,

    required String whats,
    required String address , required  String city  ,  required double long   ,
    required double late }) {
    final coordinates = GeoCode();
    List<String > keys =[];
    List<String >names = name.split(" ");
    keys = [id , email ,
      myLocationDatamap[this. city.name],
    myLocationDatamap[this. address.name],

     phone ,    whats ,  phone , whats , city , address , late.toString() , long.toString()

      ,
    ] ;
    keys.addAll(names);


    mymap = {

      this.email.name :email ,    this.name.name: name, this.state.name : USER_STATE_DONNER
      ,  this.phone.name : phone , this.whatsphone.name: whats ,isavalble.name : false ,
      this.address.name:address , this.city.name:city , this.late.name:late , this.long.name :long
      ,this.keywords.name:keys,this.id.name : id  };
    usermap = mymap;
    notifyListeners();


  }




 Future    addDataSearcher(String id,String email  ,{required  String name, required String phone,

    required String whats,  required  int age ,required isnew   }){

   List<String > keys =[];
   List<String >names = name.split(" ");
   keys = [id , email ,    phone ,     whats ,  phone , whats , age.toString()] ;
   keys.addAll(names);

   mymap = {this.name.name: name,this.id.name:id ,
     this.email.name :email,   this.phone.name : phone , this.whatsphone.name: whats ,
     this.age.name :age , keywords.name:keys ,  this.state.name : USER_STATE_SEARCHER } ;
usermap = mymap;
 notifyListeners() ;
  if (isnew) {
    return addDataCloudFirestore(
      collection: COLLECTION_USER_DATA, mymap: mymap, id: id,);
  } else {
    return  editDataCloudFirestore(collection: COLLECTION_USER_DATA, mymap: mymap ,id: id, );


  }



  }



//   Future    addDataSearcherRigister(String id,String email  ,{required  String name, required String phone,
//
//     required String whats,  required  int age   }){
//
//     List<String > keys =[];
//     List<String >names = name.split(" ");
//     keys = [id , email ,  phone ,  phone ,  whats ,  whats , age.toString()] ;
//     keys.addAll(names);
//
// mymap = {this.name.name: name,this.id.name:id ,
//   this.email.name :email,   this.phone.name : phone , this.whatsphone.name: whats ,
//   this.age.name :age , keywords.name:keys ,  this.state.name : USER_STATE_SEARCHER };
//
//    notifyListeners() ;
//     return  addDataCloudFirestore(collection: COLLECTION_USER_DATA, mymap:mymap ,  id: id, );
//
//   }

  loc.Location location = loc.Location();//explicit reference to the Location class
  Future<bool> _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
      return false ;
    }else {return true ;}}
  void pushbyState(BuildContext context   ){
String id = mymap[this. id.name];
     getSingleData(COLLECTION_USER_DATA, mymap[ this.  id.name]  )
        .then((value) {
      int v = value![ state.name];
      switch (v) {
        case 0 :

          pushReplace(RegestScreen(), context);
          break;
        case UserData.USER_STATE_DONNER :
          usermap = mymap ;
          notifyListeners();
          pushReplace(DonnerHomeScreen(), context);
          break;
        case UserData.USER_STATE_SEARCHER :
          usermap = mymap ;
          notifyListeners();

              pushReplace(SearcherHomeScreen(), context);




          break;
      }
      mymap = value;
      mymap.addAll({this.  id.name:id });
      notifyListeners();
    }) ..onError((error, stackTrace) {
       pushReplace(RegestScreen(), context);

     });



  }
  List<Map<String  , dynamic>> maplist = [];
  Future <QuerySnapshot >     getDonnersinmap(String where)  {
    List<Map<String  , dynamic>> ls = [];
  return  laodData(COLLECTION_USER_DATA,  where );
}
  Future <QuerySnapshot > laodData(String collection,   String wher )async{

    CollectionReference firebaseCollection;
    firebaseCollection =
        FirebaseFirestore.instance.collection(collection);
    return await  firebaseCollection.where(state.name,isEqualTo: 1 ).
    where(keywords.name , arrayContains: wher ).
    get() ;
  }

  Future <QuerySnapshot >     getDonnerFavorate(  )  {
    List<Map<String  , dynamic>> ls = [];
    return  laodData1(setfivratecollection(mymap[id.name])  );
  }

  Future <QuerySnapshot >     getDonnerMovment(  )  {
    List<Map<String  , dynamic>> ls = [];
    return  laodData1(setmovementcollection(mymap[id.name])  );
  }

  Future<QuerySnapshot>loadSearcher(String phone){
    return getCollrection(COLLECTION_USER_DATA)
        .where(keywords.name  ,arrayContains: phone )

        .get();
 }
  String setfivratecollection(String uid ){
    return'$COLLECTION_USER_DATA/$uid/$COLLECTION_FAVORATE_DATA';
  }



  Future addFivorate(String uid , String fivoid, Map<String ,dynamic>map){
   return  addDataCloudFirestore(collection: setfivratecollection(uid), mymap: map  , id: fivoid);
  }
Future <void > removeFivorate(String uid , String fivoid ){
 return   deleteDataCloudFirestore(collection: setfivratecollection(uid),   id: fivoid);
  }


  List<Map<String, dynamic>> getDataasfevorate( QuerySnapshot  snapshot,{ String?  idcell } ) {
    List<Map<String, dynamic>> getlist =   <Map<String, dynamic>>[]  ;

    QuerySnapshot qs = snapshot;
    qs.docs.map((doc ){
      Map<String  , dynamic>   docmap  = Map();
      docmap = doc.data()!as Map<String,dynamic>;
      if (idcell!=null){
        docmap.addAll({idcell: doc .id}); }
      docmap.addAll({'r': false });
      getlist.add( docmap);

    }).toList();

    return getlist ;
  }


  String setmovementcollection(String uid ){
    return'$COLLECTION_USER_DATA/$uid/$COLLECTION_Movement_DATA';
  }
  void addMovement(String uid ,   Map<String ,dynamic>map){
    addDataCloudFirestore(collection: setmovementcollection(uid), mymap: map   );
  }
  Future <void > removeMovemant(String uid , String fivoid ){
    return   deleteDataCloudFirestore(collection: setmovementcollection(uid),   id: fivoid);
  }
  List<Map<String, dynamic>> getDataasMovment( QuerySnapshot  snapshot,{ String?  idcell } ) {



    List<Map<String, dynamic>> getlist =   <Map<String, dynamic>>[]  ;

    QuerySnapshot qs = snapshot;
    qs.docs.map((doc ){
      Map<String  , dynamic>   docmap  = Map();
      docmap = doc.data()!as Map<String,dynamic>;
      if (idcell!=null){
        docmap.addAll({idcell: doc .id}); }
      docmap.addAll({'r': false });
      getlist.add( docmap);

    }).toList();

    return getlist ;
  }


  Future <int> getUserState()async{
  int i =0;
    getSingleData(COLLECTION_USER_DATA, mymap[ id.name])
.then((value) {
  i =  value![state.name];
  return i ;
});

return i ;
}
static const String SHAREDPREFRANCE_KEY_STATE='USER STATE';
  static const int SHAREDPREFREANCE_Non = 0;

 static const int SHAREDPREFREANCE_GOOGLE = 1;
  static const int SHAREDPREFREANCE_Email = 2 ;
  //>>>>>
  static const String SHAREDPREFRANCE_KEY_EMAIL='USER EMAIL';
  static const String SHAREDPREFRANCE_KEY_PASSWORD='USER PASS';

}