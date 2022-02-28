import 'package:hive/hive.dart';
part 'transaction_model.g.dart';


@HiveType(typeId: 0)
class Transaction extends HiveObject{
  @HiveField(0)
  late String name;

  @HiveField(1)
  late DateTime dateTime;

  @HiveField(2)
  late bool isextense;

  @HiveField(3)
  late double amount;
  
  
  
}