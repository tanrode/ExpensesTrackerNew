import 'package:flutter/material.dart';
import './transaction.dart';
import 'dart:async';
import './dbHelper.dart';
import './widgets/start.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      home: ExpenseTracker(),
    );
  }
}

class ExpenseTracker extends StatefulWidget {
  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
 
  DBhelper db = DBhelper();
  List<Transactions> items;
  int start=0;
  String amt;
  String name;
  String date;

  void setStart() async
  {
    items = await db.dogs();
    setState(() {
      start=1;
    });
  }

  void addItem(String amt, String name, String date) async {
    if(name.isEmpty || amt.isEmpty || date.isEmpty)
      return;
    if(int.parse(amt)<=0)
      return;  
    await db.insertTransaction(Transactions(name: name,amt: int.parse(amt),date: date));
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

  void startTransaction(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx, builder: (ctx) {
      return GestureDetector(
          onTap: () {},
          child: Card(
                elevation: 7,
                borderOnForeground: true,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      TextField(decoration: InputDecoration(labelText: 'Enter Item'), onChanged: (val) => name = val,),
                      TextField(decoration: InputDecoration(labelText: 'Enter Price'),keyboardType: TextInputType.number, onChanged: (val) => amt = val,),
                      TextField(decoration: InputDecoration(labelText: 'Date'), keyboardType: TextInputType.datetime, onChanged: (val) => date=DateFormat('yMMMd').format(DateTime.now()) ,),
                      Row(
                        children: <Widget>[
                          RaisedButton(child: Text('Add'), onPressed: () => addItem(amt,name,date),),
                          RaisedButton(child: Text('Delete'), onPressed: () => removeItem(name), ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ],
                  ),
                ),
              ),
          behavior: HitTestBehavior.opaque,
      );
    });
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(30, 30, 30, 1),
        bottomNavigationBar: BottomAppBar(child: Text('Created by TanLabs',textAlign: TextAlign.center,style: TextStyle(fontSize:16,fontWeight: FontWeight.w500),),),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add) , onPressed: (() => startTransaction(context))),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 153, 230, 1),
          title: Text('Expense Tracker'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add) , onPressed: () => startTransaction(context),color: Color.fromRGBO(0, 0, 0, 1),)
          ],
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.all(4),
          child: SingleChildScrollView(
                      child: Column(
              children: <Widget>[
               // Input(name, amt.toString(), date, addItem, removeItem),
                start == 0 ?
                Start(setStart):
                Column(
                  children: <Widget>[
                    Container(
                      height: 145,
                      width: double.infinity,
                      child: Card(
                        child: Text('Chart will come here',style: TextStyle(fontSize:30,fontWeight:FontWeight.bold),textAlign: TextAlign.center,),
                      ),
                    ),
                    Container(
                      height: 336,
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}