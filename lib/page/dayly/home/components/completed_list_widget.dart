import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:flutter_app_todo_app/page/dayly/home/components/todo_widget.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:flutter_app_todo_app/utils/database_helper.dart';
import 'package:provider/provider.dart';

class CompletedListWidget extends StatefulWidget {
  @override
  _CompletedListWidgetState createState() => _CompletedListWidgetState();
}

class _CompletedListWidgetState extends State<CompletedListWidget> {



  DatabaseHelper _dbHelper;

  List<Todo> _todos = List<Todo>();



  refreshTodoList() async {
    final provider = Provider.of<TodosProvider>(context);
    List<Todo> allList = await _dbHelper.fetchTodos();

    setState(() {
      provider.todos = allList
          .where((todo) => todo.isDone == 1 && todo.monday == 1 &&
          todo.tuesday == 1 && todo.wednesday == 1 && todo.thursday == 1 && todo.friday == 1 && todo.saturday == 1 && todo.sunday == 1 )
          .toList();
      _todos = provider.todos;
    });


  }

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    refreshTodoList();
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
    // final provider = Provider.of<TodosProvider>(context);
    // final todos = provider.todosCompleted;

    return _todos.isEmpty ? Center(
      child: Text('毎日やる完了したタスクはございません',
        style: TextStyle(fontSize: 20),),
    )
        :
    ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        separatorBuilder: (context,index) => Container(
          height:16 ,
        ),
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return TodoWidget(todo: todo);
        },
        itemCount: _todos.length);
  }
}
