import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todos_alex/Home/ListFragment/TodoListItem.dart';
import 'package:todos_alex/Providers/ListProvider.dart';
import 'package:todos_alex/main.dart';

class ListFragment extends StatefulWidget {
  Function onDaySelected;
  ListFragment(this.onDaySelected);
  @override
  _ListFragmentState createState() => _ListFragmentState();
}

class _ListFragmentState extends State<ListFragment> {
  ListProvider listProvider;
  CollectionReference todos;
  DateTime selectedDay =DateTime.now();
  DateTime focusedDay=DateTime.now();

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      child: Column(
        children: [
      TableCalendar(
      firstDay:DateTime.now().subtract(Duration(days: 365)),
      lastDay:DateTime.now().add(Duration(days: 365)),
      focusedDay:focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(selectedDay, day);
        },
        currentDay: selectedDay,

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
             widget.onDaySelected(selectedDay);
            // update `_focusedDay` here as well
          });
          getTodosFromFireStore();
        },
        calendarFormat: CalendarFormat.week,
        headerVisible: false,
        weekendDays:  [],
        daysOfWeekStyle: DaysOfWeekStyle(
          decoration: BoxDecoration(
            color: Colors.white
          )
        ),
        calendarStyle: CalendarStyle(
          selectedTextStyle: TextStyle(color: MyThemeData.primaryColor),

          selectedDecoration: BoxDecoration(
            color: Colors.white,

          ),
          weekendDecoration:BoxDecoration(
            color: Colors.white
          ),
          defaultDecoration:BoxDecoration(
            color: Colors.white
          )
        ),
       ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return TodoListItem(listProvider.todosList[index],onCheckBoxClicked,onDeleteClicked);
            },
            itemCount: listProvider.todosList.length,
          ))
        ],
      ),
    );
  }

  initState() {
    // TODO: implement initState
    super.initState();
    todos = FirebaseFirestore.instance.collection('todos');
    getTodosFromFireStore();
  }

  getTodosFromFireStore() {
    List<Todo> todosList = [];
    todos.get().then((QuerySnapshot querySnapshot) {
      todosList = querySnapshot.docs.map((document) {
        Timestamp timestamp = document['date'] as Timestamp;
        return Todo(
            id: document.id,
            title: document['title'],
            content: document['content'],
            isDone: document['isDone'],
            dateTime: timestamp.toDate());
      }).toList();

     todosList=todosList.where((element) =>element.dateTime.day==selectedDay.day).toList();
     todosList.sort((Todo a,Todo b){
      return a.dateTime.compareTo(b.dateTime);
     });
      listProvider.updateList(todosList);
    });
  }
  void onCheckBoxClicked(Todo item){
    todos.doc(item.id)
        .update({'isDone': item.isDone?false:true})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    listProvider.refreshList(selectedDay);
  }
  void onDeleteClicked(Todo item){
    todos.doc(item.id)
        .delete()
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    listProvider.refreshList(selectedDay);
  }
}
