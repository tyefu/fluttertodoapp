import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:flutter_app_todo_app/page/today/home/components/todo_form_widget.dart';
import 'package:flutter_app_todo_app/utils/database_helper.dart';
import 'package:flutter_app_todo_app/utils/utils.dart';
import 'package:provider/provider.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key key,@required this.todo}) : super(key: key);


  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  String title;
  String description;

  final _formKey = GlobalKey<FormState>();

  DatabaseHelper _dbHelper;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    title = widget.todo.title;
    description = widget.todo.description;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.delete), onPressed: ()async{
            // final provider = Provider.of<TodosProvider>(context,listen: false);
            // provider.removeTodo(widget.todo);
            await _dbHelper.deleteTodo(widget.todo.id);

            final provider = Provider.of<TodosProvider>(context,listen: false);
            provider.removeTodo(widget.todo);
            print('----------------');
            Navigator.of(context).pop();
          })
        ],
        title: Text('今日やること 編集'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: TodoFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title){
              setState(() {
                this.title = title;
              });
            },
            onChangeDescription: (description){
              setState(() {
                this.description = description;
              });
            }, onSavedTodo: () {
              saveTodo();
          },
          ),
        ),
      )
    );
  }


  void saveTodo() {
    final isValid = _formKey.currentState.validate();
    if(!isValid){
      return;
    }else{

      _dbHelper.updateTodo(widget.todo);

      final provider = Provider.of<TodosProvider>(context,listen: false);
      provider.updateTodo(widget.todo,title,description);
      Navigator.of(context).pop();
    }
  }
}
