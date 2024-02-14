

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/logic/provider/project.dart';
import 'package:oxegen_donner/ui/icons/person_icons.dart';
import 'package:oxegen_donner/ui/icons/whatsapp_icons.dart';
import 'package:oxegen_donner/ui/page/map.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';
import 'package:oxegen_donner/ui/widgete/optional.dart';
import 'package:provider/provider.dart';
import '../gneralfunctions.dart';
import '../string.dart';
import '../value.dart';
import 'donner.dart';
import 'searcher.dart';
import 'package:location/location.dart' as loc;

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String whatsappPhone = '';
  int age1 = 20;
  int age = 20;
  String name1 = '';
  String phone1 = '';
  String whatsappPhone1 = '';
  String city1 = '';
  String address1 = '';

  bool unconptabalpass = false;
  loc.Location location = loc.Location();//explicit reference to the Location class
  Future<bool> _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
      return false ;
    }else {return true ;}}
  bool isdonner = false;
bool ismapused = false ;
  UserData userData = UserData();

  ProjectProvider project = ProjectProvider();

  bool loading = false;

  bool locationloading = false;

  Location mylocation = Location();
  String city = '';
  String address = '';
  String id = '';
int state = 0;
String email = '';
  double long = 0;
  double late = 0;



  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>();
    id = userData.mymap[userData.id.name];
    email = userData.mymap[userData.email.name];
    project = context.watch<ProjectProvider>();
    state =userData.mymap[userData.state.name];


    name1 = userData.mymap[userData.name.name];
    phone1 = userData.mymap[userData.phone.name];
    whatsappPhone1 = userData.mymap[userData.whatsphone.name];


    if (state == 1){
     isdonner = true;
     city1 = userData.mymap[userData.city.name];
     address1 = userData.mymap[userData.address.name];

    }else if (state == 2){
     isdonner = false ;
     age1 = userData.mymap[userData.age.name];

    }



    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),

      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            child: Column(
              children: [

            Padding(
            padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: bcbeg2
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(children: [

                  Expanded(child: MytextTilte( text:searchermyfile,)),
                  Expanded(flex: 1, child:  Image(  image: AssetImage('$profileimg')))
                  ,

                ],),
              )),
        )
        ,


      Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
                  child: Center(
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                        //  DonnerSearcherOptional(),
                          Padding(
                            padding: const EdgeInsets.all(paddingAllTextfild),
                            child: DataTextfield(
                              mainvalue: name1,
                              hint: fieldTexthintName,
                              saved: (v) {
                                name = v;
                              },
                              validate: (v) {
                                if (v == null) {
                                  return validationName;
                                }
                                ;
                              },
                              icons: Icon(
                                Person.user,
                                color: iconscolor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(paddingAllTextfild),
                            child: DataTextfield(
                              textInputType: TextInputType.phone,
                              mainvalue: phone1,
                              hint: fieldTexthintphone,
                              saved: (v) {
                                phone = v;
                              },
                              validate: (String? v) {
                                if (v!.length < 8) {
                                  return validationPhone;
                                }else if (v.length !=11){
                                  if(v!=phone1){
                                  return validationphonelength;}
                                }
                              },
                              icons: Icon(
                                Icons.phone,
                                color: iconscolor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(paddingAllTextfild),
                            child: DataTextfield(
                              textInputType: TextInputType.phone,
                              mainvalue: whatsappPhone1,
                              hint: fieldTexthintwhatsappPhne,
                              saved: (v) {
                                whatsappPhone = v;
                              },
                              validate: (String? v) {
                                if (v!.isEmpty) {
                                  return validationWhats;
                                }else  if (v.length !=11){
                                  if(v!=phone1){
                                    return validationphonelength;}

                                }
                              },
                              icons: Icon(
                                Whatsapp.iconmonstr_whatsapp_1,
                                color: iconscolor,
                              ),
                            ),
                          ),
                          Container(
                            child: isdonner
                                ? Column(
                              children: [
                                Mytext(text: textaddress),
                                Padding(
                                  padding:
                                  const EdgeInsets.all(paddingAllTextfild),
                                  child: DataTextfield(
                                    hint: fieldTexthintCity,
                                    saved: (v) {
                                      address = v;
                                    },
                                    validate: (String? v) {
                                      if (v!.isEmpty) {
                                        return validationcity;
                                      }
                                    },
                                    icons: Icon(
                                      Icons.location_city,
                                      color: iconscolor,
                                    ),
                                    mainvalue:late!=0? city:city1,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.all(paddingAllTextfild),
                                  child: DataTextfield(
                                    hint: fieldTexthintaddresse,
                                    saved: (v) {
                                      city = v;
                                    },
                                    validate: (String? v) {
                                      if (v!.isEmpty) {
                                        return validationaddress;
                                      }
                                    },
                                    icons: Icon(
                                      Icons.location_city,
                                      color: iconscolor,
                                    ),
                                    mainvalue: late!=0? address:address1,

                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.all(paddingAllTextfild),
                                  child: Mybuttonsicons(
                                    text: 'تحديد الموقع',
                                    textcolor: botton,
                                    icon: Icon(Icons.location_on, color: botton),
                                    bcg: fontbtn,
                                    inloading: locationloading,
                                    onpress: () {
                                      setState(() {
                                        ismapused = true;
                                      });
                                      _checkGps().then((value) {
                                        if (value){
                                        push(MapSample(),context);}
                                        else {

                                         
                                        }
                                      });

                                     },
                                  ),
                                )
                              ],
                            )
                                : Padding(
                              padding: const EdgeInsets.all(paddingAllTextfild),
                              child: DataTextfield(
                                textInputType: TextInputType.number,
                                hint: fieldTexthintage,
                               mainvalue: age1.toString(),
                                saved: (v) {
                                  age = int.parse(v);
                                },
                                validate: (String? v) {
                                  if (v!.isEmpty) {
                                    return validationAge;
                                  }
                                },
                                icons: Icon(
                                  Icons.calendar_today,
                                  color: iconscolor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Mybuttons(
                            text: bottonSignupupdate,
                            onpress: onsignup,
                            bcg: botton,
                            inloading: loading,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }


  void onsignup() {
    if (loading) {
      return;
    }
    if (formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      formkey.currentState!.save();
      if (isdonner) {

        if (long == 0 || late == 0) {
           if (ismapused){
             long = userData.myLocationDatamap[userData.long.name];
             late  = userData.myLocationDatamap[userData.late .name];
             if (long == 0 || late == 0) {
               Widget cancelButton = MaterialButton(
                 child: Text("موافق",style: TextStyle(color: cancelbtn),),
                 onPressed: () {
                   setState(() {
                     Navigator.of(context).pop();
                     userData.setDataDonnermap(id, email,
                         name: name,
                         phone: phone,
                         whats: whatsappPhone,
                         address: address,
                         city: city,
                         long: long,
                         late: late);
                     loading = false ;
                   });



                 },
               );
               showDialog(context: context, builder: (contexts)
               {
                 return AlertDialog(
                   content: Text(
                       'يجب تحديد موقعك من الخريطة' ),
                   actions: [
                     cancelButton
                   ],
                 );
               });

               return ;
             }


             userData.addDataDonner(id, email,isnew:false
               ,   name: name,
                 phone: phone,
                 whats: whatsappPhone,
                 address: address,
                 city: city,
                 long: long,
                 late: late) ;
             Navigator.pop(context);

           }else {
           setState(() {
             loading = false ;
           });
          Widget cancelButton = MaterialButton(
            child: Text("موافق",style: TextStyle(color: cancelbtn),),
            onPressed: () {
              setState(() {
                userData.setDataDonnermap(id, email,
                    name: name,
                    phone: phone,
                    whats: whatsappPhone,
                    address: address,
                    city: city,
                    long: long,
                    late: late);
              });

              name1 = name;
              phone1 = phone;
              whatsappPhone1 = whatsappPhone;


              city1 = city;
              address1 = address;

              Navigator.of(context).pop();
            },
          );
          showDialog(context: context, builder: (contexts)
          {
            return AlertDialog(
              content: Text(
                  'يجب تحديد موقعك من الخريطة' ),
              actions: [
                cancelButton
              ],
            );
          });}
        } else {
          userData.addDataDonner(id, email,
              isnew:false,
              name: name,
              phone: phone,
              whats: whatsappPhone,
              address: address,
              city: city,
              long: long,
              late: late) ;
          Navigator.pop(context);
        }
      } else {
        userData.addDataSearcher(id, email,isnew: false ,
            name: name, phone: phone, whats: whatsappPhone, age: age);
        pushReplace(SearcherHomeScreen(), context);
      }
    }
  }
}
