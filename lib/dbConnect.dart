import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './transaction.dart';

void main() async
{
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'expensesDB.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE itemInfo1(id varchar(5) primary key,title varchar(30) not null,amt numeric(12,2) not null,date Date not null)');
    });

    // Insert some records in a transaction
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO itemInfo1 VALUES("i4","Jeans",1500.00,"28-Mar-20")');
      print('inserted1: $id1');
      int id2 = await txn.rawInsert(
          'INSERT INTO itemInfo1 VALUES("i5","Dinner",500.00,"25-Mar-20")');
      print('inserted2: $id2');
    });

}


