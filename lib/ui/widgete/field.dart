import 'package:flutter/material.dart';
class Fieldindvedual extends StatefulWidget {

  String lable = 'label';
  String value = 'vale';

  Fieldindvedual({required this.lable,required this.value});

  @override
  _FieldindvedualState createState() => _FieldindvedualState();
}

class _FieldindvedualState extends State<Fieldindvedual> {
  @override
  Widget build(BuildContext context) {
    return Container(


      child: ListTile(
        title: Text(widget.lable,style: TextStyle(fontSize: 20),),
        subtitle: Text(widget.value,textAlign: TextAlign.center,),
      ),
    );
  }
}
