import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Input extends StatelessWidget {
  String name;
  int amt;
  String date;
  final Function addItem;
  final Function removeItem; 
  Input(this.name,this.amt,this.date,this.addItem,this.removeItem);
  
  @override
  Widget build(BuildContext context) {
    return Card(
                elevation: 7,
                borderOnForeground: true,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      TextField(decoration: InputDecoration(labelText: 'Enter Item'), onChanged: (val) => name = val,),
                      TextField(decoration: InputDecoration(labelText: 'Enter Price'),onChanged: (val) => amt = int.parse(val),),
                      TextField(decoration: InputDecoration(labelText: 'Date'),onChanged: (val) => date=DateFormat('yMMMd').format(DateTime.now()) ,),
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
              );
  }
}