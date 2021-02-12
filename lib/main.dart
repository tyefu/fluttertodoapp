import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/page/dayly/home/home_page.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = '毎日やること';
  static final String week = '曜日ごとにやること';
  static final String specify = '特定の日にやること';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(


          primarySwatch: Colors.pink,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        home: HomePage(),
      ),
    );
  }
}

