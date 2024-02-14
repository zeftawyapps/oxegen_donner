import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxegen_donner/logic/module/donnertools.dart';
import 'package:oxegen_donner/ui/value.dart';
import 'package:oxegen_donner/ui/widgete/donnerdrower.dart';
import 'package:oxegen_donner/ui/widgete/donnerpanner.dart';
import 'package:oxegen_donner/ui/widgete/donnertools.dart';
import 'package:oxegen_donner/ui/widgete/mywedgets.dart';

import '../string.dart';

class DonnerHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DonnerToolsprovider donnerTools = DonnerToolsprovider();

    donnerTools.addDataDonnter();
    donnerTools.getsurow();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: DonnerDrower(),
        body: FadeInRight(
          child: Container(
            child: DonnerTools(),
          ),
        ),
      ),
    );
  }


}



