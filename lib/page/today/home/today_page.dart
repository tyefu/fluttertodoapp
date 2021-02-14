import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/helpers/drawer_navigation.dart';
import 'package:flutter_app_todo_app/helpers/notification_plugin.dart';
import 'package:flutter_app_todo_app/main.dart';

import 'components/AddTodoDialogWidget.dart';
import 'components/completed_list_widget.dart';
import 'components/todo_list_widget.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationPlugIn.setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugIn.setOnNotificationClick(onNotificationClick);
  }
  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.today),
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
            barrierDismissible: true);
        },
        child: Icon(Icons.add),
      ),
    );

  }
  onNotificationInLowerVersions(ReceivedNotification receivedNotification){

  }
  onNotificationClick(String payload){
    print('Payload $payload}');
  }
}
