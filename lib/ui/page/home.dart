import 'package:flutter/material.dart';
import 'package:oxegen_donner/logic/module/user.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeDataState createState() => _HomeDataState();
}

class _HomeDataState extends State<HomeScreen> {
  UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserData>();
    return FutureBuilder(
        future:userData.getUserState() ,
        builder: (context ,AsyncSnapshot<int > i ){

      return Container(child: Column(children: [],),);
    });
  }
}
