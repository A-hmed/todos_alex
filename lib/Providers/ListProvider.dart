import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todos_alex/Home/ListFragment/TodoListItem.dart';

class ListProvider extends ChangeNotifier{
  List<Todo> todosList=[];

  refreshList(DateTime selectedDay ){
    if(selectedDay!=null){
      print('selected day in refresh function is ${selectedDay.day}');
    CollectionReference todos=FirebaseFirestore.instance.collection('todos');
    print('in Refresh Method');
    todos.get()
        .then((QuerySnapshot querySnapshot) {
        todosList=querySnapshot.docs.map((document) {
          print('mapping document to todo with title ${document['title']}');
          Timestamp timestamp=document['date'] as Timestamp;

          print('After where document to todo with title ${document['title']}');
          return Todo(id:document.id,title: document['title'],content:document['content'],isDone: document['isDone'],dateTime:timestamp.toDate() );
        }).toList();

        todosList=todosList.where((element) =>element.dateTime.day==selectedDay.day).toList();
        todosList.sort((Todo a,Todo b){
          return a.dateTime.compareTo(b.dateTime);
        });

        notifyListeners();
    });}
  }
  updateList(List<Todo> newList){
    todosList=newList;
    notifyListeners();
  }

}