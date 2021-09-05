import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_alex/Home/HomeScreen.dart';
import 'package:todos_alex/Providers/ListProvider.dart';
import 'package:todos_alex/Providers/ThemeProvider.dart';


   main()  async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     FirebaseFirestore.instance.settings =
         Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
     await FirebaseFirestore.instance.disableNetwork();
     runApp(MyApp());
}
void intializeFireStore()async{


  await FirebaseFirestore.instance.disableNetwork();
}
class MyThemeData{
    static final primaryColor=Color(0xFF5D9CEC);
    static final accentColor=Color(0xFFDFECDB);
    static final greenColor=Color(0xFF61E757);
    static final darkAccentColor=Color(0xFF060E1E);
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create:(_)=> ListProvider(),
      builder: (context,widget){
         return ChangeNotifierProvider(
            create: (_)=>ThemeProvider(),
            builder:(context,widget){
              final themeProvider=Provider.of<ThemeProvider>(context);
              return MaterialApp(
                themeMode: themeProvider.themeMode,
                theme: ThemeData(
                    primaryColor: MyThemeData.primaryColor,
                    accentColor: MyThemeData.accentColor
                ),
                darkTheme: ThemeData(
                    primaryColor:MyThemeData.primaryColor,
                    accentColor: MyThemeData.darkAccentColor
                ),
                routes: {
                  HomeScreen.ROUTE_NAME:(context)=>HomeScreen()
                },
                initialRoute: HomeScreen.ROUTE_NAME,
              ) ;}

        );}
        );

  }


  }





