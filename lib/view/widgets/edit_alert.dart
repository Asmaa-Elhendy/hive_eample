import 'package:flutter/material.dart';
import 'package:hive_study/model/transaction_model.dart';

class EditAlert extends StatefulWidget {
Transaction transaction;
EditAlert({required this.transaction});
  @override
  _EditAlertState createState() => _EditAlertState();
}

class _EditAlertState extends State<EditAlert> {
  int selectedvalue=0;
  TextEditingController namecontroller=TextEditingController();
  TextEditingController amountcontroller=TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text=widget.transaction.name;
    amountcontroller.text=widget.transaction.amount.toString();
    selectedvalue=widget.transaction.isextense?0:1;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Transaction'),
      content: SingleChildScrollView(
        child: ListBody(
          children:  <Widget>[
            TextField(
              controller: namecontroller,
            ),
            TextField(
              controller: amountcontroller,
            ),
            Row(
              children: [
                Radio(groupValue: selectedvalue , value: 0,
                  onChanged: (int ?value){
                    setState(() {
                      selectedvalue= value!;
                    });
                  },
                  activeColor: Color(0xff3e50b9),
                ),Text('Expense')
              ],
            ),
            Row(
              children: [
                Radio(groupValue: selectedvalue , value: 1,
                  onChanged: (int ?value){
                    setState(() {
                      selectedvalue= value!;
                    });
                  },
                  activeColor: Color(0xff3e50b9),
                ),
                Text('Income')
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel',style: TextStyle(color: Color(0xff3e50b9),),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Save',style: TextStyle(color: Color(0xff3e50b9),),),
          onPressed: () {
           widget.transaction.name=namecontroller.text;
           widget.transaction.amount=double.parse(amountcontroller.text);
           widget.transaction.isextense=selectedvalue==0?true:false;
           widget.transaction.dateTime=DateTime.now();
           widget.transaction.save();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }



}
