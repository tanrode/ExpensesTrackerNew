import 'package:flutter/material.dart';
import './widgets/start.dart';

class StartMBS
{
  String name;
  String amt;
  String date;
  Function addItem;
  Function removeItem;
  StartMBS();
  void modalSheet(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx, builder: (_) {
      return Text('Hello');//Input(name, amt, date, addItem, removeItem);
    });
  }
}