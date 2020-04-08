import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './transaction.dart';

class DBhelper
{
  //TestWidgetsFlutterBinding.ensureInitialized();
  //WidgetsFlutterBinding.ensureInitialized();
  Future<Database> database() async
  {
      var database;
      if(database == null)
      {
          database = openDatabase(join(await getDatabasesPath(), 'expenses_database.db'),onCreate: (db, version) 
          {
            return db.execute("CREATE TABLE transactions(name TEXT,amt INTEGER,date TEXT)",
          );
          },version: 1,);
      }
    return database;
  }
  

  Future<void> insertTransaction(Transactions txn) async {
    // Get a reference to the database.
    final Database db = await database();

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'transactions',
      txn.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Transactions>> dogs() async {
    // Get a reference to the database.
    final Database db = await database();
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('transactions');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Transactions(
        name: maps[i]['name'],
        amt: maps[i]['amt'],
        date: maps[i]['date'],
      );
    });
  }

  Future<void> updateTransaction(Transactions txn) async {
    // Get a reference to the database.
    final Database db = await database();

    // Update the given Dog.
    await db.update(
      'transactions',
      txn.toMap(),
      // Ensure that the Dog has a matching id.
      where: "name = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [txn.name],
    );
  }

  Future<void> deleteTransaction(String name) async {
    // Get a reference to the database.
    final Database db = await database();

    // Remove the Dog from the database.
    await db.delete(
      'transactions',
      // Use a `where` clause to delete a specific dog.
      where: "name = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [name],
    );
  }
}
