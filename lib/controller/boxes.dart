import 'package:hive/hive.dart';
import 'package:hive_study/model/transaction_model.dart';

class Boxes{
  
  static getTransactions(){
    return Hive.box<Transaction>('transactions');
  }
  
  
}