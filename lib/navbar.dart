import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(DateFormat('d').format(DateTime.now()), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Column(
                  children: [
                    Text(DateFormat('MMM').format(DateTime.now()).toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(DateFormat('y').format(DateTime.now())),
                  ],
                ),
              ],
            ),
            Text(DateFormat('EEEEE').format(DateTime.now()).toUpperCase())
          ],
        ),
      ],
    );
  }
}
