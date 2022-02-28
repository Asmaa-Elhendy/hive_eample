import 'package:flutter/material.dart';

class ShowAlert extends StatefulWidget {
  Function add;
  ShowAlert({required this.add});

  @override
  _ShowAlertState createState() => _ShowAlertState();
}

class _ShowAlertState extends State<ShowAlert> {
  int selectedvalue=0;
  TextEditingController namecontroller=TextEditingController();
  TextEditingController amountcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: const Text('Add Transaction'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    hintText: "Enter Name",

                  ),
                ),
                TextField(
                  controller: amountcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter Amount",

                  ),
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
              child: const Text('Add',style: TextStyle(color: Color(0xff3e50b9),),),
              onPressed: () {
                widget.add(namecontroller.text,double.parse(amountcontroller.text),selectedvalue);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }



}
