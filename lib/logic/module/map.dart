import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';
import 'package:oxegen_donner/logic/lib/modulscreateor.dart';

class MapData extends Module with ChangeNotifier{
  Cell address = Cell('address');
  Cell city = Cell('city');
  Cell loction = Cell('loction');
  Cell long = Cell('long');
  Cell late = Cell('late');
  void setloaction(double long , double late){
    mymap= {this.long.name :long , this.late.name : late };
    notifyListeners() ;
  }
  void getposstion(){
   determinePosition().then((value) {
     setloaction(value.latitude, value.longitude);});



  }
  // void getloction1(){
  //  // getLocationpgs().then((value)   async {
  //     final coordinates = GeoCode();
  //
  //     coordinates.reverseGeocoding(
  //        latitude: value.latitude!, longitude: value.longitude!).then((value) {
  //       //  latitude: 30.805322, longitude: 30.992964).then((value) {
  //
  //       var f = value ; });
  //      setloaction(value.latitude!, value.longitude!);});
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
    if (permission == LocationPermission.always) {

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.

  //  Geolocator.openLocationSettings();
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

