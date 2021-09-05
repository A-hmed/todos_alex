import 'package:flutter/material.dart';

import '../../main.dart';
import 'LanguageBottomSheet.dart';
class SettingsFragment extends StatefulWidget {


  @override
  _SettingsFragmentState createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme :',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            InkWell(
              onTap: (){
                showLanguageBottomSheet();
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: MyThemeData.primaryColor,width: 2)
                ),
                margin: EdgeInsets.all(12),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(child: Text('Language',style: TextStyle(fontSize: 14,color: MyThemeData.primaryColor))),
                      Icon(Icons.arrow_downward_outlined,color: MyThemeData.primaryColor,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ) ,
    );
  }
  showLanguageBottomSheet(){
    showModalBottomSheet(context: context, builder: (context){
      return LanguageBottomSheet();
    });
  }
}
