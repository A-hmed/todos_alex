import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_alex/Home/BottomSheetWidget.dart';
import 'package:todos_alex/Home/ListFragment/ListFragment.dart';
import 'package:todos_alex/Home/SettingsFragment/SettingsFragment.dart';

import 'package:todos_alex/main.dart';

class HomeScreen extends StatefulWidget {
  static String ROUTE_NAME='Home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay;
  int selectedIndex=0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text('To doList'),
        toolbarHeight: 120,
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(30))
        ),

        child: FloatingActionButton(
          onPressed: (){ShowModalBottomSheet();},
          child: Icon(Icons.add),

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
      clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: BottomNavigationBar(
          onTap: (selectedIndex){
            setState(() {
              this.selectedIndex=selectedIndex;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                label: 'home',
                icon: Icon(Icons.list)),
            BottomNavigationBarItem(
                label: 'settings',
                icon: Icon(Icons.settings))
          ],
        ),
      ),
      body: selectedIndex==0?ListFragment(onDaySelected):SettingsFragment(),
    );
  }
  void onDaySelected(DateTime selectedDay){
    this.selectedDay=selectedDay;
  }
  void ShowModalBottomSheet(){
    showModalBottomSheet(context: context, builder: (context){
      return BottomSheetWidget(selectedDay);
    });
  }

}
