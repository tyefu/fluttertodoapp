import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:flutter_app_todo_app/page/dayly/home/components/todo_widget.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:flutter_app_todo_app/page/weekly/weeklyhome/components/week_of_day_list.dart';
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

    List<Todo> x = await _dbHelper.fetchTodos();
    switch (provider.selectedWeekOfDay) {
      case 0:
        {
          setState(() {
            provider.todos = x
                .where((todo) => todo.isDone == 1 && todo.monday == 1)
                .toList();
            _todos = provider.todos;
          });
          break;
        }
      case 1:
        {
          setState(() {
            provider.todos = x
                .where((todo) => todo.isDone == 1 && todo.tuesday == 1)
                .toList();
            _todos = provider.todos;
          });
          break;
        }
      case 2:
        {
          setState(() {
            provider.todos = x
                .where((todo) => todo.isDone == 1 && todo.wednesday == 1)
                .toList();
            _todos = provider.todos;
          });
          break;
        }
      case 3:
        {
          setState(() {
            provider.todos = x
                .where((todo) => todo.isDone == 1 && todo.thursday == 1)
                .toList();
            _todos = provider.todos;
          });
          break;
        }
      case 4:
        {
          setState(() {
            provider.todos = x
                .where((todo) => todo.isDone == 1 && todo.friday == 1)
                .toList();
            _todos = provider.todos;
          });
          break;
        }
      case 5:
        {
          setState(() {
            provider.todos = x
                .where((todo) => todo.isDone == 1 && todo.saturday == 1)
                .toList();
            _todos = provider.todos;
          });
          break;
        }
      case 6:
        {
          setState(() {
            provider.todos = x
                .where((todo) => todo.isDone == 1 && todo.sunday == 1)
                .toList();
            _todos = provider.todos;
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

    return Column(
      children: [
        WeekOfDayList(),
        _todos.isEmpty
            ? Center(
          child: Text(
            'No Complete Todos',
            style: TextStyle(fontSize: 20),
          ),
        )
            : Expanded(
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              separatorBuilder: (context, index) => Container(
                height: 16,
              ),
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return TodoWidget(todo: todo);
              },
              itemCount: _todos.length),
        ),
      ],
    );
  }
}
