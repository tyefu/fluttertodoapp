import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/helpers/notification_plugin.dart';
import 'package:flutter_app_todo_app/model/todo.dart';

import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:flutter_app_todo_app/page/today/home/components/todo_form_widget.dart';

import 'package:flutter_app_todo_app/utils/database_helper.dart';
import 'package:flutter_app_todo_app/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  DatabaseHelper _dbHelper;

  // List<Todo> _todos = List<Todo>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  _showSuccessSnackBar(Text message){
    var _snackBar = SnackBar(content: message,);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  // refreshTodoList() async {
  //   final provider = Provider.of<TodosProvider>(context,listen: false);
  //   List<Todo> x = await _dbHelper.fetchTodos();
  //
  //     provider.todos = x.where((todo) => todo.isDone == 0).toList();
  //
  //     print(provider.todos.length);
  //     // print(_todos.length);
  //
  //
  // }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // refreshTodoList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '今日やること追加',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TodoFormWidget(
                onChangedTitle: (title) {
                  setState(() {
                    this.title = title;
                  });
                },
                onChangeDescription: (description) {
                  setState(() {
                    this.description = description;
                  });
                },
                onSavedTodo: addTodo)
          ],
        ),
      ),
    );
  }

  void addTodo() async {
    // await notificationPlugIn.showNotification();
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      // String formattednowDate = (DateTime.parse(DateFormat('yyyy-MM-dd')
      //     .format(DateTime.now())).toString());
      final todo = Todo(
        createdTime: DateTime.now().toString(),
        title: title,
        description: description,
        id: null,
        monday: 0,
        tuesday: 0,
        wednesday: 0,
        thursday: 0,
        friday: 0,
        saturday: 0,
        sunday: 0,
      );
        await _dbHelper.insertTodo(todo);
        // _showSuccessSnackBar(Text("Todo Create Success"));

        print('insert success');
      final provider = Provider.of<TodosProvider>(context, listen: false);
        provider.addTodo(todo);

      // final provider = Provider.of<TodosProvider>(context, listen: false);
      //
      // provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
