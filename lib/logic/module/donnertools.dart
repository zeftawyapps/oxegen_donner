
import 'package:flutter/cupertino.dart';
import 'package:oxegen_donner/logic/lib/modulscreateor.dart';

class DonnerToolsprovider extends ChangeNotifier {

  Map<String , Map<String , int > > donnerTools = Map<String , Map<String , int > >() ;


  List<Map<String , dynamic >> toolschosed=[];
  void addtheTallsChossed(Map<String , dynamic> m){

    toolschosed.add(m);
    notifyListeners();
  }
  String setToolsAsString = '';


  String donnertoolsString(){
   String s  ='';
   int i = 0  ;
int c = toolschosed.length ;
  while(i<c ) {

     s =  s + toolschosed[i]['maindep']+' '+
         toolschosed[i] ['maindepart']+' عدد '+
         toolschosed[i] ['qunat'].toString() +'\n';

 i ++;
  }
   setToolsAsString = s ;
   notifyListeners() ;
    return s ;
  }
  List<RowofCells> donnerlist = [];
  void setquntity(int i , String s,String  v  ){
    toolschosed[i][s]  = int.parse(v);
notifyListeners() ;
  }
  void addDataDonnter(){
    donnerlist.clear();
  donnerlist.add(DonnerToolsData('10',  'انابيب', 'انابيب',1).rowofCells);
  donnerlist.add(DonnerToolsData('20',  'مولد', '10 لتر', 1).rowofCells);
  donnerlist.add(DonnerToolsData('21', 'مولد', '5 لتر', 1).rowofCells);
  donnerlist.add(DonnerToolsData('30' ,  'اسطوانة', '10 لتر', 1).rowofCells);
  donnerlist.add(DonnerToolsData('31' , 'اسطوانة', '20 لتر ', 1).rowofCells);
  donnerlist.add(DonnerToolsData('32' , 'اسطوانة', '30 لتر ', 1).rowofCells);
  notifyListeners();
}
  List<Map<String , dynamic >> loadwhere(String s){
    Module mm = Module() ;
    List<Map<String , dynamic >> newdata=[];
    List<Map<String , dynamic >> data =  mm.getListmap(donnerlist);
newdata =  data.where((element) {
 return  element[DonnerToolsData.name().maindepart.name ]==s;

 }).toList();
    return newdata ;
  }
void getsurow()      {
    DonnerToolsData.name();
Module mm = Module() ;
mm.getListmap(donnerlist);
mm.sumBy(mm.listMaps,DonnerToolsData.name().maindepart , DonnerToolsData.name().qunat);
}


}
class DonnerToolsData     {
  Cell maindepart = Cell('maindep');
  Cell partdep = Cell('maindepart');
  Cell qunat = Cell('qunat');
Cell id = Cell('id');

  DonnerToolsData.name();

  late  RowofCells rowofCells ;
  DonnerToolsData(String id ,  String  maindep, String part , int q ){
    maindepart.value = maindep;
  partdep.value = part ;
    qunat.value = q ;
this.id.value = id ;
    rowofCells = RowofCells([maindepart , partdep , qunat ]);


  }
}