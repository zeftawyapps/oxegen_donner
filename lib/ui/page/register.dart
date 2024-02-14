import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxegen_donner/logic/lib/google.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/logic/provider/project.dart';
import 'package:oxegen_donner/ui/gneralfunctions.dart';
import 'package:oxegen_donner/ui/icons/person_icons.dart';
import 'package:oxegen_donner/ui/icons/whatsapp_icons.dart';
import 'package:oxegen_donner/ui/page/register.dart';
import 'package:oxegen_donner/ui/page/searcher.dart';
import 'package:oxegen_donner/ui/widgete/optional.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../string.dart';
import '../value.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';
import 'package:location/location.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart' as loc;

import 'donner.dart';
import 'map.dart';

class RegestScreen extends StatefulWidget {
  const RegestScreen({Key? key}) : super(key: key);

  @override
  _RegestScreenState createState() => _RegestScreenState();
}

class _RegestScreenState extends State<RegestScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String whatsappPhone = '';
  String city = '';
  String address = '';

  int age = 20;


  bool unconptabalpass = false;

  bool isdonner = false;

  UserData userData = UserData();

  ProjectProvider project = ProjectProvider();

  bool loading = false;

  bool locationloading = false;

  Location mylocation = Location();
  String id = '';

  String email = '';
  double long = 0;
  double late = 0;
  loc.Location location = loc.Location();//explicit reference to the Location class
  Future<bool> _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
      return false ;
    }else {return true ;}}
  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>();
    id = userData.mymap[userData.id.name];
    email = userData.mymap[userData.email.name];
    project = context.watch<ProjectProvider>();
    isdonner = project.isdonner;


    return Scaffold(
        backgroundColor: bcbeg2,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bgimg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Container(
                    child: FadeInRight(child: w()),
                  ))),
        ));
  }

  Widget w() {
    return SingleChildScrollView(
        child: Column(
          children: [
            MytextTilte(
              text: title,
            ),
            Image(width: 200, height: 200, image: AssetImage(charactterimg)),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50))),
              child: Center(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MytextTilteblack(text: textRegestData),
                      DonnerSearcherOptional(),
                      Padding(
                        padding: const EdgeInsets.all(paddingAllTextfild),
                        child: DataTextfield(

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
                          hint: fieldTexthintphone,
                          saved: (v) {
                            phone = v;
                          },
                          validate: (String? v) {
                            if (v!.length != 11 ) {
                              return validationphonelength ;
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
                          hint: fieldTexthintwhatsappPhne,
                          saved: (v) {
                            whatsappPhone = v;
                          },
                          validate: (String? v) {
                            if (v!.isEmpty) {
                              return validationWhats;
                            }else {
                              if (v.length !=11){
                                return validationphonelength;
                              }
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
                                    city = v;
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
                                  mainvalue: city
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.all(paddingAllTextfild),
                              child: DataTextfield(
                                  hint: fieldTexthintaddresse,
                                  saved: (v) {
                                    address = v;
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
                                  mainvalue: address
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
                                  push(MapSample(),context);
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
                        text: bottonSignupRegist,
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
        ));
  }
  bool ismapused = false ;
  void onsignup(  ) {
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

            userData.addDataDonner(id, email,
                isnew:true  ,
                name: name,
                phone: phone,
                whats: whatsappPhone,
                address: address,
                city: city,
                long: long,
                late: late).then((value) {
              pushReplace(DonnerHomeScreen(), context);
            }) ;

          }else {
            setState(() {
              loading = false ;
            });
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
            });}
        }
else {
        userData.addDataDonner(id, email,
            isnew:true ,
            name: name,
            phone:  phone,
            whats:   whatsappPhone,
            address: address,
            city: city,
            long: long,
            late: late ).then((value) {
          pushReplace(DonnerHomeScreen(), context);
        });
      }} else {
        userData.addDataSearcher(id, email,isnew:  true ,
            name: name, phone : phone, whats:  whatsappPhone, age: age)
.then((value)  {


   _checkGps().then((value) {
     if (value ){
       pushReplace(SearcherHomeScreen(), context);
     }
   } );

        })
        ;
      }
    }
    setState(() {
      loading = false;
    });
  }
}

