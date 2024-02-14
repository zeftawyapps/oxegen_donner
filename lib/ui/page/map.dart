import 'dart:async';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oxegen_donner/logic/module/map.dart';
import 'package:location/location.dart' as loc;

import '../string.dart';
import '../value.dart';


class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  MapData mapData = MapData() ;
  Completer<GoogleMapController> _controller = Completer();
  final coordinates = GeoCode();

double long=0; double late = 0 ;
  double long1=0; double late1 = 0 ;
UserData userData = UserData();
bool loactiondisabled = false  ;
  String city='';

  String address='';

  bool loading = false ;
  loc.Location location = loc.Location();//explicit reference to the Location class
  Future _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  @override
  void initState() {
    super.initState();//comes first for initState();
//_checkGps();
  }

  @override
  Widget build(BuildContext context) {
    mapData = context.watch<MapData>();
    userData = context.watch<UserData>();

    addmarker();
    return  Scaffold(


    body: FutureBuilder<Position>(
      future: determinePosition(),
      builder: (BuildContext context, ff ) {
        if (loactiondisabled){
         _checkGps();
Navigator.pop(context);
        }
loading = true ;
          long = ff.data!.longitude;
          late = ff .data!.latitude ;
          coordinates
              .reverseGeocoding(
              latitude: late ,
              longitude: long )
              .then((value) {
            var first = value;
            print(first.city);

            city = first.city!;
            address = first.streetAddress!;



          });
         addmarker() ;
          return WillPopScope(
            onWillPop: () async {
           return _onBackPressed();
            },
            child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(children: [

                  Expanded(flex: 6,
                    child: Stack(
                     children: [
                       GoogleMap(
                         onTap:(v)   {
                           loading = false;
                           setState(() {
                             long1 = v.longitude;
                             late1 = v .latitude;});
                             coordinates
                                 .reverseGeocoding(
                                 latitude: long1,
                                 longitude: late1)
                                 .then((value) {
                               var first = value;

                             setState(() {
        {
        city = first.city!;
        address = first.streetAddress!;
        }
                             });

                             });

                         }  ,
                         mapType: MapType.normal,
                         initialCameraPosition: CameraPosition(

                           target: LatLng(  late , long),
                           zoom: 15,
                         ),

                         onMapCreated: (GoogleMapController controller) {
                           _controller.complete(controller);
                         },

                         markers: Set<Marker>.of(_markers),

                       )
,
                       Padding(
                         padding: const EdgeInsets.only(
                             bottom: 20, left: 10, right: 10),
                         child: Container(
                           alignment: Alignment.bottomLeft,
                           child: MaterialButton(
                             onPressed: _goToTheLake,
                             child: Icon(
                               Icons.gps_fixed,
                               color: Colors.black,
                               size: 40,
                             ),
                           ),
                         ),
                       )
                     ] ,
                    ),
                  ),


                  Expanded(flex: 1, child:
                  Mybuttons(
                    text: bottonSignupRegist,
                    onpress: (){
if (late1 == 0){
  Widget cancelButton = MaterialButton(
    child: Text("موافق",style: TextStyle(color: cancelbtn),),
    onPressed: () {
      Navigator.of(context).pop();

    },
  );
  showDialog(context: context, builder: (contexts)
  {
    return AlertDialog(
      content: Text(
            'رجاء قم بتحديد موقعك على الخريطة ' ),
      actions: [
         cancelButton
      ],
    );
  });
  return;
}
                      userData.setLocationmap(late1, long1, city, address);
                      Navigator.of(context).pop();
                    },
                    bcg: botton,

                  ),
                  ),

                ],),
              ),
            ),
        ),
          );
      },

    )
    ,
      );
  }

  Future<void> _goToTheLake() async {

    final GoogleMapController controller = await _controller.future;

    determinePosition().then((value) {

setState(() {
  long = value.longitude;
  late = value .latitude;
  late1 = late;
  long1 = long;
  coordinates
      .reverseGeocoding(
      latitude: value.latitude,
      longitude: value.longitude)
      .then((value) {
    var first = value;
    print(first.city);

    city = first.city!;
    address = first.streetAddress!;

  });

});


        addmarker() ;
    });


    controller.animateCamera(CameraUpdate.newCameraPosition(

        CameraPosition(

            bearing: 0,
            target: LatLng(late,  long ),
           // target:  LatLng(30.805322,  30.992964),
            tilt: 90,
            zoom: 16

        )


    ));

addmarker();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
     serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        loactiondisabled = true;
      });
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
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  List<Marker> _markers = [];


  void addmarker(){

    _markers = [];
    _markers.add(
        Marker(
            markerId: MarkerId('SomeId'),
            position: LatLng( late1  , long1  ),

            infoWindow: InfoWindow(
                title: 'موقعي'
            )
        )
    );
  }


  Future<bool> _onBackPressed() async {
    // Your back press code here...
    userData.setLocationmap(0, 0, '', '');
    Navigator.of(context).pop();
return true;
  }
}