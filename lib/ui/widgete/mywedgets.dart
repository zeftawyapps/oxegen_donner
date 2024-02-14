

import 'package:flutter/material.dart';
import 'package:oxegen_donner/ui/icons/whatsapp_icons.dart';
import 'package:oxegen_donner/ui/value.dart';

class MytextTilte extends StatelessWidget {
  String text = ' ';

  MytextTilte({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: titel,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: titelfomyfont),
    );
  }
}
class MytextTilteblack extends StatelessWidget {
  String text = ' ';

  MytextTilteblack(  {required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: textcolor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: titelfomyfont),
    );
  }
}
class Mytext extends StatelessWidget {
  String text = ' ';

  Mytext({required this.text});
    @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style:
          TextStyle(color: textcolor, fontSize: 16, fontFamily: titelfomyfont),
    );
  }
}


class Mybuttons extends StatelessWidget {
  String text = '';
  var onpress;
  Color bcg = botton;
  bool  inloading =false  ;
  Mybuttons({required this.text,this.onpress  ,required this.bcg ,this.inloading=false  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpress,

      textColor: fontbtn,
      minWidth: double.infinity,

      child: Container(
        width: double.infinity,
        decoration:  BoxDecoration(
            color: bcg  ,
          borderRadius: BorderRadius.circular(20)
    ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:inloading?Center(
            child: CircularProgressIndicator(
              color: fontbtn ,
            ),
          ) : Text(

            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: fontbtn, fontSize: 16, fontFamily: titelfomyfont),
          ),
        ),
      ),
    );
  }
}
class Mybuttonsicons extends StatelessWidget {
  String text = '';
  var onpress;
  Color bcg = botton;
  Icon? icon = Icon(Icons.mail_outline_outlined);
  bool  inloading =false  ;
  Color textcolor  ;
  Mybuttonsicons({required this.text,this.onpress ,
    this.icon ,required this.textcolor ,
     required this.bcg ,this.inloading=false  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpress,

      textColor: fontbtn,
      minWidth: double.infinity,

      child: Container(
        width: double.infinity,
        decoration:  BoxDecoration(
            color: bcg  ,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
           Expanded(
               flex: 1,
               child: icon!)
            ,
            Expanded(flex: 5,
              child: Text(

                text,
                textAlign: TextAlign.start,
                style: TextStyle(color: textcolor, fontSize: 16, fontFamily: titelfomyfont),
              ),
            )

              ,inloading?Center(
                child: CircularProgressIndicator(
                  color: textcolor ,
                ),
              ) :Container()
          ],) ,
        ),
      ),
    );
  }
}
class MybuttonsWithImage extends StatelessWidget {
  String text = '';
  var onpress;
   Color bcg = Colors.white;
   Color? fontcolr = textcolor;
  String  image ;
  MybuttonsWithImage({required this.text,this.onpress , this.fontcolr   ,required this.image });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpress,

      textColor: fontbtn,
      minWidth: double.infinity,

      child: Container(
        width: double.infinity,
        decoration:  BoxDecoration(
            image: DecorationImage(image: AssetImage(image ))  ,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(

            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: fontcolr, fontSize: 16, fontFamily: titelfomyfont),
          ),
        ),
      ),
    );
  }
}
class DataTextfield extends StatefulWidget {

  String  hint = "" ;String mainvalue = '';
var  saved  ;Icon icons;var validate; bool?  ispassord=false;
  TextInputType _textInputType = TextInputType.text ;
  DataTextfield({required this.hint ,required this.validate ,required  this.saved , required this.icons , this.ispassord,
     this.mainvalue='',
    TextInputType ? textInputType} ) {

    if (textInputType == null  ) {_textInputType = TextInputType.text ; }else {
      _textInputType = textInputType ;

    }
  }

  @override
  _DataTextfieldState createState() => _DataTextfieldState();
}

class _DataTextfieldState extends State<DataTextfield> {
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
      decoration: InputDecoration(

        labelStyle: TextStyle(color: hintcolor),
        labelText: widget.hint,
        // hintText: hint,
        // hintStyle: TextStyle(color: hintcolor),
        filled: true ,
        fillColor:  textf,
        prefixIcon: widget.icons,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide: BorderSide.none ,
        ),

      ),
      onSaved: widget.saved,
      validator:widget.validate

    ,obscureText: widget.ispassord==null?false :widget.ispassord!  ,

    );


  }
}



class DataTextfieldSearch extends StatefulWidget {

  String  hint = "" ;String mainvalue = '';
  var  saved    ;var validate; bool?  ispassord=false;
  TextInputType ? textInputType;
  double? fontsize = 20;
  DataTextfieldSearch({required this.hint ,required this.validate ,required  this.saved ,  this.ispassord,
    this.mainvalue='',
   this.  textInputType,this.fontsize} ) {


  }

  @override
  _DataTextfieldStateSearch createState() => _DataTextfieldStateSearch();
}

class _DataTextfieldStateSearch extends State<DataTextfieldSearch> {
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
      style: TextStyle(fontSize: widget.fontsize),
      keyboardType:widget.textInputType ,
      controller: controller,
      decoration: InputDecoration(


        labelStyle: TextStyle( color: hintcolor,fontSize: 10 ),
        labelText: widget.hint,

        filled: true ,
        fillColor:  Colors.white,

        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(15.0),
          borderSide:BorderSide.none,
        ),

      ),

      onSaved: widget.saved,
      validator:widget.validate



    );


  }
}


