import 'package:flutter/foundation.dart';
//import 'dart:async';

//import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';

class Transactions
{
   int id;
   String title;
   double amt;
   DateTime date;

  Transactions({this.id,this.title,this.amt,this.date});


  int get id1 => id;
  String get title1 => title;
  double get amt1 => amt;
  DateTime get date1 => date;

  set id1(int s)
  {
    this.id=s;
  }

  set title1(String s)
  {
    this.title=s;
  }

  set amt1(double s)
  {
    this.amt=s;
  }

  set date1(DateTime s)
  {
    this.date=s;
  }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map['id']=id;
    map['title']=title;
    map['amt']=amt;
    map['date']=date;

    return map;
  }

  Transactions.fromMapObject(Map<String,dynamic> map){
    this.id=map['id'];
    this.title=map['title'];
    this.amt=map['amt'];
    this.date=map['date'];
  }
}