import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import './transaction.dart';

class DBhelper
{
  static DBhelper _myHelper;
  static Database _database;

  final String itemInfo='itemInfo';
  final String id='id';
  final String title='title';
  final String amt='amt';
  final String date='date';
  DBhelper._createInstance();

  factory DBhelper()
  {
    if(_myHelper == null)
    {
      _myHelper=DBhelper._createInstance();
    }

    return _myHelper;
  }

  Future<Database> get database async
  {
    if(_database == null)
    {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async
  {
    //Get directory path
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Expenses.db';

    //Open/create Database at a given path
    var expensesDB = await openDatabase(path, version: 1, onCreate: _createDB);
    
    return expensesDB;
  }

  void _createDB(Database db,int newVersion) async
  {
    await db.execute('CREATE TABLE $itemInfo($id INTEGER PRIMARY KEY , $title TEXT ,'
                    '$amt numeric(12,2) , $date Date');
  }

  //Fetch operation: Get all Objects from database 
  Future<List<Map<String, dynamic>>> getTransactionMapList() async{
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $itemInfo');
    return result;  
  }

  //Insert operation: Insert a new object into the database
  Future<int> insertTransaction(Transactions txn) async
  {
    Database db = await this.database;
    var result = await db.insert(itemInfo, txn.toMap());
    return result; 
  }

  Future<int> updateTransaction(Transactions txn) async
  {
    var db = await this.database;
    var result = await db.update(itemInfo, txn.toMap(), where: '$id = ?', whereArgs: [txn.id]);
    return result;
  }

  Future<int>deleteTransaction(int myid) async
  {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $itemInfo WHERE $id = $myid');
    return result;
  }

  //Get Number of objects in the database 
  Future<int> getCount() async
  {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $itemInfo');
    int result = Sqflite.firstIntValue(x);
    return result; 
  }

  Future<List<Transactions>> getTransactionList() async
  {
    var txnMapList = await getTransactionMapList();
    int count = txnMapList.length;

    List<Transactions> txnList = List<Transactions>();

    for(int i=0;i<count;i++)
    {
      txnList.add(Transactions.fromMapObject(txnMapList[i]));
    }

    return txnList;  
  }

}