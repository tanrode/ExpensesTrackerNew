import 'package:flutter/material.dart';
import './transaction.dart';
import 'dart:async';
import './dbHelper.dart';
import './input.dart';

void main()
{
  runApp(ExpenseTracker());
}

class ExpenseTracker extends StatefulWidget {
  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
 
  DBhelper db = DBhelper();
  List<Transactions> items;
  int start=0;
  int amt;
  String name;
  String date;

  void addItem(int amt, String name, String date) async {
    await db.insertTransaction(Transactions(name: name,amt: amt,date: date));
    items = await db.dogs();
    setState(() {
      start = 1;
    });
  }

  void removeItem(String name) async {
    await db.deleteTransaction(name);
    items = await db.dogs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(30, 30, 30, 1),
        bottomNavigationBar: BottomAppBar(child: Text('Created by TanLabs',textAlign: TextAlign.center,style: TextStyle(fontSize:16,fontWeight: FontWeight.w500),),),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 153, 230, 1),
          title: Text('Expense Tracker'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.all(4),
          child: SingleChildScrollView(
                      child: Column(
              children: <Widget>[
                Input(name, amt, date, addItem, removeItem),
                start == 1 ?
                Container(
                  height: 236,
                  child: ListView(
                    children: items.map((txn) {
                        return Card(
                          elevation: 10,
                          child: Container(
                            decoration: BoxDecoration(color: Color.fromRGBO(0, 191, 230, 1)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 140,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Color.fromRGBO(221, 255, 100, 1)),
                                  child: Text('Rs. '+txn.amt.toString(),textAlign: TextAlign.center, style: TextStyle(fontSize: 22),),
                                  ),
                                Container(
                                  width: 180,
                                  child: Column(
                                    children: [
                                      Text(txn.name,textAlign: TextAlign.center,style: TextStyle(fontSize:21,fontWeight: FontWeight.bold,color: Color.fromRGBO(250, 234, 215, 1)),),
                                      Text('Date: '+txn.date,textAlign: TextAlign.center,style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Color.fromRGBO(200, 234, 190, 1)),),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                    }).toList()
                  ),
                ): Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}