import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';

class TodosProvider extends ChangeNotifier {

  List<Todo> todos = [
  ];
  List<Todo> todayTodos = [];
  List<Todo> weeklyTodos = [];
  List<Todo> specifyTodos = [];
  int selectedWeekOfDay = 0;
  String selectedWeek = "月";
  int selected = 0;


  //isDoneは0ならFalseでまだ完了していない
//   List<Todo> get todos => _todos.where((todo) => todo.isDone == 0).toList();
//
//   List<Todo> get todosCompleted =>
//       _todos.where((todo) => todo.isDone == 1).toList();
// }
  //曜日を0~6で表している
  void selectedWeekOfDayFunc(index){
    selectedWeekOfDay = index;
    if(index == 0){
      selectedWeek = '月';
    }else if(index == 1){
      selectedWeek = '火';
    }else if(index == 2){
      selectedWeek = '水';
    }else if(index == 3){
      selectedWeek = '木';
    }else if(index == 4){
      selectedWeek = '金';
    }else if(index == 5){
      selectedWeek = '土';
    }else if(index == 6){
      selectedWeek = '日';
    }
    notifyListeners();
  }
  // void addTodoTodays(Todo todo) {
  //   todayTodos.add(todo);
  //   notifyListeners();
  // }
  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

//
  void removeTodo(Todo todo) {
    todos.remove(todo);
    notifyListeners();
  }

 int toggleTodoStatus(Todo todo) {
    todo.isDone == 0 ? todo.isDone = 1 : todo.isDone = 0;
    notifyListeners();
    return todo.isDone;

  }
//
  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
//
//
 }
