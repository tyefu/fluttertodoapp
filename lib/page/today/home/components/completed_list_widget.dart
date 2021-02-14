import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:flutter_app_todo_app/page/today/home/components/todo_widget.dart';
import 'package:flutter_app_todo_app/utils/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CompletedListWidget extends StatefulWidget {
  @override
  _CompletedListWidgetState createState() => _CompletedListWidgetState();
}

class _CompletedListWidgetState extends State<CompletedListWidget> {




  DatabaseHelper _dbHelper;

  List<Todo> _todos = List<Todo>();
  List<Todo> _todayTodos = List<Todo>();
  List<Todo> _weeklyTodos = List<Todo>();



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
    final provider = Provider.of<TodosProvider>(context);
    List<Todo> allList = await _dbHelper.fetchTodos();

    switch (week-1) {
      case 0:
        {
          setState(() {
            provider.weeklyTodos = allList
                .where((todo) => todo.isDone == 1 && todo.monday == 1)
                .toList();
            provider.todayTodos = allList.where((todo) => todo.isDone == 1 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
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
            provider.weeklyTodos = allList
                .where((todo) => todo.isDone == 1 && todo.tuesday == 1)
                .toList();
            provider.todayTodos = allList.where((todo) => todo.isDone == 1 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _weeklyTodos = provider.weeklyTodos;
            _todayTodos = provider.todayTodos;
            _todos =   _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 2:
        {
          setState(() {
            provider.weeklyTodos = allList
                .where((todo) => todo.isDone == 1 && todo.wednesday == 1)
                .toList();
            provider.todayTodos = allList.where((todo) => todo.isDone == 1 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _weeklyTodos = provider.weeklyTodos;
            _todayTodos = provider.todayTodos;
            _todos =   _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 3:
        {
          setState(() {
            provider.weeklyTodos = allList
                .where((todo) => todo.isDone == 1 && todo.thursday == 1)
                .toList();
            provider.todayTodos = allList.where((todo) => todo.isDone == 1 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _weeklyTodos = provider.weeklyTodos;
            _todayTodos = provider.todayTodos;
            _todos =   _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 4:
        {
          setState(() {
            provider.weeklyTodos = allList
                .where((todo) => todo.isDone == 1 && todo.friday == 1)
                .toList();
            provider.todayTodos = allList.where((todo) => todo.isDone == 1 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _weeklyTodos = provider.weeklyTodos;
            _todayTodos = provider.todayTodos;
            _todos =   _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 5:
        {
          setState(() {
            provider.weeklyTodos = allList
                .where((todo) => todo.isDone == 1 && todo.saturday == 1)
                .toList();
            provider.todayTodos = allList.where((todo) => todo.isDone == 1 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _weeklyTodos = provider.weeklyTodos;
            _todayTodos = provider.todayTodos;
            _todos =   _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
      case 6:
        {
          setState(() {
            provider.weeklyTodos = allList
                .where((todo) => todo.isDone == 1 && todo.sunday == 1)
                .toList();
            provider.todayTodos = allList.where((todo) => todo.isDone == 1 && todoDateCreatedToFormat(todo) == formattednowDate).toList();
            _weeklyTodos = provider.weeklyTodos;
            _todayTodos = provider.todayTodos;
            _todos =   _todayTodos + _weeklyTodos;
            provider.todos = _todos;
          });
          break;
        }
    }


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
      child: Text('完了したタスクはございません',
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
