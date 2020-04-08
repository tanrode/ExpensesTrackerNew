import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Start extends StatelessWidget {
  final Function setStart;
  Start(this.setStart);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 470,
      child: Column(
        children:[
          Text('Expense Tracker',style: TextStyle(fontSize:40,fontWeight:FontWeight.bold,color: Color.fromRGBO(255, 255, 255, 1)),),
          RaisedButton(child: Text('Begin',style: TextStyle(fontSize:15,fontWeight:FontWeight.bold)), onPressed: setStart,),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,),
    );
  }
}