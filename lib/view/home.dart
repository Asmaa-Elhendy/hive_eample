import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_study/controller/boxes.dart';
import 'package:hive_study/model/transaction_model.dart';
import 'package:hive_study/view/widgets/alertsave.dart';
import 'package:hive_study/view/widgets/edit_alert.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Color defaultcolor= Colors.black;
  Color appcolor=  Color(0xff3e50b9);

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.box('transactions').close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff3e50b9),
        onPressed: () async{
         await  showDialog(
         context: context,
         //    barrierDismissible: false, // user must tap button!
         builder: (BuildContext context) {
           return ShowAlert(add: setstatevaluesToAdd,);
         }
    );},
        child: Icon(Icons.add,color: Colors.white,size: 28,),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff3e50b9),
        centerTitle: true,
        title: Text('Hive'),
      ),
      body: ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Hive.box<Transaction>('transactions').listenable(),
        builder:(context,box,_){
        final  transactions= box.values.toList().cast<Transaction>();
        print(transactions);
          return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context,int index){

                return customExpandedTile(transactions[index]);
              });
        },
      ),
    );
  }
 Widget customExpandedTile(Transaction transaction){
  return Padding(
    padding:  EdgeInsets.only(bottom: 8.0),
    child: ExpansionTile(title: Text(transaction.name,style: TextStyle(color: Colors.black),),
       subtitle: Text('${transaction.dateTime.toString().substring(0,16)}  / ${transaction.isextense}',style: TextStyle(color: Colors.black),),
       trailing: Text('\$ ${transaction.amount.toString()}',style: TextStyle(color: Colors.red[600],fontSize: 16),),
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             TextButton(onPressed: ()async{
              await  showDialog(context: context, builder: (BuildContext context){
                 return EditAlert(transaction:transaction,);
               });
             }, child: Row(
               children: [
                 Icon(Icons.edit,size: 20,color: appcolor,),
                 SizedBox(width: 5,),
                 Text('Edit',style: TextStyle(color: appcolor),),
               ],
             )),
             TextButton(onPressed: (){
             setState(() {
               transaction.delete();
             });
            }, child: Row(
               children: [
                 Icon(Icons.delete,size: 20,color: appcolor,),
                 SizedBox(width: 5,),
                 Text('Delete',style: TextStyle(color: appcolor),),
               ],
             ))
           ],)
       ],
     ),
  );
 }
//add to box
setstatevaluesToAdd(namecontroller,amountcontroller,selectedvalue){
  final transaction=Transaction()..name=namecontroller..amount=amountcontroller..isextense=selectedvalue==0?true:false..dateTime=DateTime.now();
 final box =Boxes.getTransactions();
 box.add(transaction);
 //box.put('key',transaction);



  }



}
