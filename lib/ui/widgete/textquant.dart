import 'package:flutter/material.dart';

import '../value.dart';
class DataTextfieldQuantity extends StatefulWidget {

  String  hint = "" ;String mainvalue = '';
  var  saved  ; var validate; bool?  ispassord=false;
  TextInputType _textInputType = TextInputType.text ;
  DataTextfieldQuantity({ required this.validate ,required  this.saved ,
    this.mainvalue='',
    TextInputType ? textInputType} ) {

    if (textInputType == null  ) {_textInputType = TextInputType.text ; }else {
      _textInputType = textInputType ;

    }
  }

  @override
  _DataTextfieldQuantityState createState() => _DataTextfieldQuantityState();
}

class _DataTextfieldQuantityState extends State<DataTextfieldQuantity> {
  var form ;
  TextEditingController controller =    TextEditingController() ;


  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    if (widget.mainvalue!= ''){
      controller..text = widget.mainvalue;}

    return TextFormField(
      keyboardType:widget._textInputType ,
      controller: controller,
      textAlign: TextAlign.center,

        style:
        TextStyle(color: textcolor, fontSize: 20, fontFamily: titelfomyfont),

      decoration: InputDecoration(

        filled: true ,
        fillColor:  textf,

        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide: BorderSide.none ,
        ),

      ),
      onSaved: widget.saved,
      validator:widget.validate

      ,

    );


  }
}
