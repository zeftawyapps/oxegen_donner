import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oxegen_donner/logic/module/map.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/ui/icons/whatsapp_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../string.dart';
import '../value.dart';
import 'mywedgets.dart';

class SearcherMap extends StatefulWidget {
  const SearcherMap({Key? key}) : super(key: key);

  @override
  _SearcherMapState createState() => _SearcherMapState();
}

class _SearcherMapState extends State<SearcherMap> {
  MapData mapData = MapData();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Completer<GoogleMapController> _controller = Completer();

  double long = 30;
  double myloctionlong = 30;
  double late = 30;
  double myloctionlate = 30;
String where = '';String s = '';
  UserData userData = UserData();
  late Timer timer;
  late Marker mymarker;
  bool istimeruned = false;
  final coordinates = GeoCode();

  String city='';

  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>();
    try {
      return FutureBuilder<Position>(
        future: determinePosition(),
        builder: (context, ff) {
          long = ff.data!.longitude;
          late = ff.data!.latitude;

          myloctionlong = ff.data!.longitude;
          myloctionlate = ff.data!.latitude;
          coordinates
              .reverseGeocoding(
              latitude:  ff.data!.latitude,
              longitude: ff.data!.longitude)
              .then((value) {
            var first = value;
            print(first.city);

            city = first.city!;
where = city ;
          });

          return FutureBuilder<QuerySnapshot>(
              future: userData.getDonnersinmap(where ),
              builder: (c, snap) {
                List<Map<String, dynamic>> _getlist = <Map<String, dynamic>>[];
                _getlist = userData.getDataasopject(snap.data!,idcell: userData.id.name);
                userData.maplist.clear();
                _getlist.map((e) {
                  if (e[userData.state.name] == 1) {
                    userData.maplist.add(e);
                  }
                }).toList();

                return Container(
                  child: Center(
                    child: Container(
                        child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Stack(
                            children: [
                              Container(
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(late, long),
                                    zoom: 10,
                                  ),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                  markers: Set<Marker>.of(
                                      addmarkers(userData.maplist)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 40, left: 20, right: 20),
                                child: Container(
                                    width: 500,
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
                                                hint: 'ابحث باسم',
                                                validate: (v) {},
                                                saved: (v) {
                                                  s = v ;

                                                },
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: MaterialButton(
                                              onPressed: () {
                                                formkey.currentState!.save();
                                                setState(() {
                                                  where = s  ;
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
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, left: 10, right: 10),
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: MaterialButton(
                                    onPressed: goloction,
                                    child: Icon(
                                      Icons.gps_fixed,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child:
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20.0) , topLeft: Radius.circular(20.0))
                            ),
                            child: Column(children: [
                              Expanded(flex: 1, child: MytextTilteblack(text: 'المؤسسات الاقرب اليك '))
                               ,
                              Expanded(flex: 3,
                                child: ListView.builder(

                                    itemCount: userData.maplist.length,
                                    itemBuilder: (c, i) {
                                      return Container(
                                        child: FadeInLeft(
                                          delay: Duration(milliseconds: 500),
                                          child: ListTile(
                                              onTap: () {
                                                userData.setDatapase(userData.maplist[i]);
fivoretadded = false ;
                                                modalBottomSheetMenu(context);
                                                setState(() async {
                                                  late = userData.maplist[i]
                                                  [userData.late.name];
                                                  long = userData.maplist[i]
                                                  [userData.long.name];
                                                  final GoogleMapController controller =
                                                  await _controller.future;

                                                  controller.animateCamera(CameraUpdate
                                                      .newCameraPosition(CameraPosition(
                                                      bearing: 0,
                                                      target: LatLng(late, long),
                                                      // target:  LatLng(30.805322,  30.992964),
                                                      tilt: 90,
                                                      zoom: 18)));
                                                });
                                              },
                                              leading:
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10) ,
                                                    color:
                                                    userData.maplist[i]
                                                    [userData.isavalble.name]?

                                                    fontbtn:fontbtn2
                                                ),
                                                child: Image(width: 70, height: 100, image: AssetImage(logodir)),
                                              )

                                              ,title:   Text(

                                            userData.maplist[i]
                                            [userData.name.name],
                                            textAlign: TextAlign.right,
                                            style:   TextStyle(color: textcolor, fontSize: 16, fontFamily: titelfomyfont),

                                          ),
                                              subtitle:   Text(
                                                userData.maplist[i]
                                                [userData.phone.name],
                                                style: TextStyle(color: textcolor, fontSize: 10, fontFamily: titelfomyfont),

                                              )

                                          ),
                                        ),
                                      ) ;
                                    }),
                              ),
                            ],)
                          ),
                        )
                      ],
                    )),
                  ),
                );
              });
        },
      );
    } on Exception catch (e) {
      return Container(
        color: Colors.green,
      );
    }
  }

  void goloction() async {
    final GoogleMapController controller = await _controller.future;

    determinePosition().then((value) {
      setState(() {
        long = value.longitude;
        late = value.latitude;
        myloctionlong = value.longitude;
        myloctionlate = value.latitude;
        mymarker = Marker(
            markerId: MarkerId('SomeId'),
            position: LatLng(myloctionlate, myloctionlong),
            infoWindow: InfoWindow(
                title: 'lat:${late.toString()},long${long.toString()}'));

        List<Map<String, dynamic>> ls = [];

        ls = userData.maplist;
        _markers = addmarkers(ls);
        where = city ;
      });
    })
      ..onError((error, stackTrace) {
        print(error.toString());
      });
    ;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(late, long),
        // target:  LatLng(30.805322,  30.992964),
        tilt: 90,
        zoom: 15)));
    // addmarker();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  List<Marker> _markers = [];

  List<Marker> addmarkers(List<Map<String, dynamic>> ls) {
    List<Marker> mm = [];
    ls = [];

    mm = [];
    ls = userData.maplist;
    int i = 0;
    try {
      mm.add(Marker(
          markerId: MarkerId('SomeId'),
          position: LatLng(myloctionlate, myloctionlong),
          infoWindow: InfoWindow(
              title: 'lat:${late.toString()},long${long.toString()}')));

      while (i < ls.length) {
        if (ls[i][userData.state.name] == 1) {
          mm.add(Marker(
              markerId: MarkerId('id' + i.toString()),
              position:
                  LatLng(ls[i][userData.late.name], ls[i][userData.long.name]),
              infoWindow: InfoWindow(title: ls[i][userData.name.name])));
        }
        i++;
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }

    _markers = mm;
    return _markers;
  }
  bool fivoretadded = false ;
  void modalBottomSheetMenu(BuildContext context) {

    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (builder) {
          return
            StatefulBuilder(builder: (context, stat) {
            bool isavalble = userData.passmap[userData.isavalble.name];
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
                              text: '${userData.passmap[userData.name.name]}',
                            )),
                        Expanded(
                            child: Mytext(
                                text:
                                '${userData.passmap[userData.city.name]}')),
                        Expanded(
                            child: Mytext(
                                text:
                                '${userData.passmap[userData.address.name]}')),
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
                                    "tel://${userData.passmap[userData.phone.name]}");
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
                                          '${userData.passmap[userData.phone.name]}')
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
                                String txt =txtmsgwhats ;
                                String s =
                                    "https://wa.me/+2${userData.passmap[userData.whatsphone.name]} ?text=$txt ";

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
                                            '${userData.passmap[userData.whatsphone.name]}'),
                                      )
                                    ]),
                              ),
                            )),
                        Expanded(
                            child: Visibility(
                              visible: !fivoretadded,
                              child: MaterialButton(
                                onPressed: () {

                                  String uid = userData.usermap[userData.id.name];

                                  userData.addFivorate(uid, userData.passmap[userData.id.name] , userData.passmap )
                                      .then((value)  {
                                    stat((){fivoretadded = true; });




                                    // key.currentState!.showSnackBar(new SnackBar(
                                  // content: new Text("تم الاضافة"),
                                  // )
                                  // );


                 });



                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.star, color: iconscolor),
                                      Text('$addtofivorate')
                                    ]),
                              ),
                            ))
                      ],
                    )),
              ),
            );
          });
        });
  }

 }
