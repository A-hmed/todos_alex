import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todos_alex/Providers/ListProvider.dart';

import 'package:todos_alex/main.dart';

class BottomSheetWidget extends StatefulWidget {
DateTime selectedDay;
BottomSheetWidget(this.selectedDay);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  ListProvider listProvider;
  String title='';
  String content='';
  DateTime dateTime=DateTime.now();
  CollectionReference todos ;
  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Add New Task',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          TextField(
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle:TextStyle(color: Color(0xFFA9A9A9))
            ),
            onChanged: (newTitle){
              title=newTitle;
            },
          ),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
                hintText: 'Content',
                hintStyle:TextStyle(color: Color(0xFFA9A9A9))
            ),
            onChanged: (newContent){
              content=newContent;
            },
          ),
          InkWell(
            onTap:showDatePickerModal ,
            child: Text('Select Time',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
          ),
          Spacer(),
          TextButton(onPressed:addTodoToFireStore , child: Container(
              color: MyThemeData.primaryColor,
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: Center(child: Text('Add Todo',style: TextStyle(fontSize: 18,color: Colors.white),))))
        ],
      ),
    );
  }
  showDatePickerModal() async {
    dateTime= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
  }
   initState()  {
    // TODO: implement initState
    super.initState();
    todos=FirebaseFirestore.instance.collection('todos');
  }

  addTodoToFireStore(){
todos.add({
      'title': title,
      'content': content,
      'date': dateTime,
       'isDone':false
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error")).whenComplete((){
          print('in when complete ');
}).timeout(Duration(seconds:1),onTimeout: (){
  listProvider.refreshList(widget.selectedDay);
  Fluttertoast.showToast(
      msg: " Todo Added Sucessfully ",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
  );
   Navigator.pop(context);
   });
  }
}
