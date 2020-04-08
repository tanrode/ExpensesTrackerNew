import 'package:flutter/foundation.dart';

class Transactions
{
  final String name; 
  final int amt;
  final String date;

  Transactions({@required this.name,@required this.amt, @required this.date});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amt': amt,
      'date': date,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Transactions{name: $name}';
  }

}