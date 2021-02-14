import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:flutter_app_todo_app/page/today/edit/edit_todo_page.dart';
import 'package:flutter_app_todo_app/page/today/home/components/todo_widget.dart';

import 'package:flutter_app_todo_app/utils/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TodoListWidget extends StatefulWidget {


  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {

  DatabaseHelper _dbHelper;

  List<Todo> _todos = List<Todo>();
  List<Todo> _todayTodos = List<Todo>();
  List<Todo> _weeklyTodos = List<Todo>();


  // List<Todo> _todos = List<Todo>();
String  todoDateCreatedToFormat(Todo todo){

  if(todo.createdTime == ''){
    return '';
  }else {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');

    DateTime dateTime = inputFormat.parse(todo.createdTime);
    String todoString = dateTime.toString();
    return todoString;
  }
}
  refreshTodoList() async {
    String formattednowDate = (DateTime.parse(DateFormat('yyyy-MM-dd')
        .format(DateTime.now())).toString());
    int week = DateTime.now().weekday;
    String now = DateTime.now().toString();

    final provider = Provider.of<TodosProvider>(context);
    List<Todo> allList = await _dbHelper.fetchTodos();




    switch (week-1) {
      case 0:
        {

            setState(() {
            provider.weeklyTodos = allList
                .where((todo) => todo.isDone == 0 && todo.monday == 1)
                .toList();
            provider.todayTodos = allList.where((todo) => todo.isDone == 0 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _weeklyTodos = provider.weeklyTodos;
            _todayTodos = provider.todayTodos;
             _todos =   _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 1:
        {
          setState(() {

            _weeklyTodos = allList
                .where((todo) => todo.isDone == 0 && todo.tuesday == 1)
                .toList();
            print(_weeklyTodos.length);
            _todayTodos = allList.where((todo) => todo.isDone == 0 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _todos = _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 2:
        {
          setState(() {

            _weeklyTodos = allList
                .where((todo) => todo.isDone == 0 && todo.wednesday == 1)
                .toList();
            print(_weeklyTodos.length);
            _todayTodos = allList.where((todo) => todo.isDone == 0 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _todos = _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 3:
        {
          setState(() {

            _weeklyTodos = allList
                .where((todo) => todo.isDone == 0 && todo.thursday == 1)
                .toList();
            print(_weeklyTodos.length);
            _todayTodos = allList.where((todo) => todo.isDone == 0 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _todos = _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 4:
        {
          setState(() {

            _weeklyTodos = allList
                .where((todo) => todo.isDone == 0 && todo.friday == 1)
                .toList();
            print(_weeklyTodos.length);
            _todayTodos = allList.where((todo) => todo.isDone == 0 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _todos = _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 5:
        {
          setState(() {

            _weeklyTodos = allList
                .where((todo) => todo.isDone == 0 && todo.saturday == 1)
                .toList();
            print(_weeklyTodos.length);
            _todayTodos = allList.where((todo) => todo.isDone == 0 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
          _todos = _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });

          break;

        }
      case 6:
        {
          setState(() {

            _weeklyTodos = allList
                .where((todo) => todo.isDone == 0 && todo.sunday == 1)
                .toList();
            print(_weeklyTodos.length);
            _todayTodos = allList.where((todo) => todo.isDone == 0 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _todos = _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
    }
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    refreshTodoList();

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    // final provider = Provider.of<TodosProvider>(context);
    // final todos = provider.todos;


    return _todos.isEmpty ? Center(
      child: Text('本日のタスクはございません',
        style: TextStyle(fontSize: 20),),
    )
        :
    ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        separatorBuilder: (context, index) =>
            Container(
              height: 16,
            ),
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return TodoWidget(todo: todo);
        },
        itemCount: _todos.length);
    // ListWheelScrollView.useDelegate(
    //   useMagnifier: true,
    //   magnification: 1.5,
    //   itemExtent: 100, childDelegate: ListWheelChildBuilderDelegate(
    //   builder: (context,index) {
    //     final todo = todos[index];
    //     return Container(
    //       height: 16,
    //         child: Center(child: TodoWidget(todo: todo,)));
    //   },
    //   childCount: todos.length
    //
    //
    // ),
    //
    // );
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditTodoPage(todo: todo),
    ));
  }
}
