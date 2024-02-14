import 'package:flutter/material.dart';

import '../string.dart';
import '../value.dart';
import 'mywedgets.dart';
class Donnerpanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFe6f4ed),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [



                      MytextTilte(text: titledonner),
                   //   Mytext(text: descridonner)


                Image(
                    width: 150, height: 150, image: AssetImage(vectorimg))
              ],
            ),
          )),
    );
  }
}