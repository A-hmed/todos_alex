import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos_alex/main.dart';

class TodoListItem extends StatefulWidget {
  Todo todo;
  Function onCheckClicked;
  Function onDeleteClicked;
  TodoListItem(this.todo,this.onCheckClicked,this.onDeleteClicked);

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: .3,
      child: Container(
       margin: EdgeInsets.only(right: 12,top: 12,bottom: 12),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 20),
              height: 60,
              width: 4,
              color:widget.todo.isDone==true
                  ? MyThemeData.greenColor
                  : MyThemeData.primaryColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todo.title,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.todo.isDone==true
                          ? MyThemeData.greenColor
                          : MyThemeData.primaryColor),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 18,
                    ),
                    SizedBox(width: 12,),
                    Text(
                      widget.todo.dateTime.toString(),
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          Spacer(),
          InkWell(
            onTap: (){
              widget.onCheckClicked(widget.todo);
            },
            child: widget.todo.isDone==true
                ? Text(
              'Done ! ',
              style: TextStyle(
                  color: MyThemeData.greenColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )
                : Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: MyThemeData.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 35,
              ),
            ),
          )
          ],
        ),
      ),
      actionPane:SlidableScrollActionPane() ,
      actions: [
        IconSlideAction(
          onTap: (){
            widget.onDeleteClicked(widget.todo);
          },
          iconWidget:Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete,size: 30,color: Colors.white,),
                Text('Delete',style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),)
              ],
            ),
          ) ,
        )
      ],
    );
  }
}

class Todo {
 String id;
  String title;
  String content;
  bool isDone;
  DateTime dateTime;

  Todo({this.id,this.title, this.content, this.isDone, this.dateTime});
}
