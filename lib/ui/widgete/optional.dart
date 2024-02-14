import 'package:flutter/material.dart';
import 'package:oxegen_donner/logic/provider/project.dart';
import 'package:provider/provider.dart';
import '../string.dart';
import '../value.dart';

class DonnerSearcherOptional extends StatefulWidget {
  const DonnerSearcherOptional({Key? key}) : super(key: key);

  @override
  _DonnerSearcherOptionalState createState() => _DonnerSearcherOptionalState();
}

class _DonnerSearcherOptionalState extends State<DonnerSearcherOptional> {
  ProjectProvider project = ProjectProvider() ;
  bool isdon = false ;
  @override
  Widget build(BuildContext context) {
    project = context.watch<ProjectProvider>();
    isdon = project.isdonner;
    return Row (children: [Expanded(flex: 1,
        child: Donnerbtn()) ,

      Expanded(flex: 1, child: Searcherbtn())],);
  }

  Widget Donnerbtn (){
    return MaterialButton(onPressed: (){
      setState(() {
        isdon = true ;
        project.setdonner(true);
      });

    }
      , child: Container(
        width: double.infinity,
        decoration:  BoxDecoration(
            color: isdon? botton : bcbeg2 ,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(

            optionbtnDonner,
            textAlign: TextAlign.center,
            style: TextStyle(color: isdon? fontbtn:titel , fontSize: 16, fontFamily: titelfomyfont),
          ),
        ),
      ), );
  }
  Widget Searcherbtn (){
    return MaterialButton(onPressed: (){
      setState(() {
        isdon = false ;
        project.setdonner(false);
      });

    }
      , child: Container(
        width: double.infinity,
        decoration:  BoxDecoration(
            color: !isdon? botton : bcbeg2 ,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(

            optionbtnSearcher,
            textAlign: TextAlign.center,
            style: TextStyle(color: !isdon? fontbtn:titel , fontSize: 16, fontFamily: titelfomyfont),
          ),
        ),
      ), );
  }
}
