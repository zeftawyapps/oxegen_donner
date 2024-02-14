import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
class ProjectProvider extends ChangeNotifier{
  bool isdonner = false ;
  Location location = new Location() ;
  void setdonner(isdon){
    isdonner =isdon ;
    notifyListeners();
  }
  Future<LocationData> getLocation() async {
     location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {

      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {

      }
    }

    _locationData = await location.getLocation();
     print(_locationData.latitude);
     print(_locationData.longitude);
     print(_locationData.toString());
     notifyListeners();
     return _locationData;
  }

}