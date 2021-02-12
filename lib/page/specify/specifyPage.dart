import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/helpers/drawer_navigation.dart';
import 'package:flutter_app_todo_app/page/specify/components/AddTodoDialogWidget.dart';
import 'package:flutter_app_todo_app/page/specify/components/completed_list_widget.dart';
import 'package:flutter_app_todo_app/page/specify/components/todo_list_widget.dart';

import '../../main.dart';
import 'components/todo_list_calendar_widget.dart';

class SpecifyPage extends StatefulWidget {

  @override
  _SpecifyPageState createState() => _SpecifyPageState();
}

class _SpecifyPageState extends State<SpecifyPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListCalendarWidget(),
      CompletedListWidget(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.specify),
      ),
      drawer: DrawerNavigation(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'やること',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done,),
            label: '完了',
          ),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: (){
          showDialog(context: context,
              child: AddTodoDialogWidget(),
              barrierDismissible: false);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

