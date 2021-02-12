import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:flutter_app_todo_app/page/specify/components/todo_form_widget.dart';
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
  String date = '';

  TextEditingController _todoDateController = TextEditingController();
  bool monDayChecked = false;
  bool tuesDayChecked = false;
  bool wednesDayChecked = false;
  bool thursDayChecked = false;
  bool friDayChecked = false;
  bool saturDayChecked = false;
  bool sunDayChecked = false;

  DatabaseHelper _dbHelper;

  // List<Todo> _todos = List<Todo>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  _showSuccessSnackBar(Text message) {
    var _snackBar = SnackBar(
      content: message,
    );
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'タスク追加',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
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
                onSavedTodo: addTodo,
                onTapDate: () async {
                  await _selectedTodoDate(context);
                },dateController: _todoDateController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;

        _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
        print(_pickedDate);
      });
    }
  }

  void addTodo() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        createdTime: DateTime.now().toString(),
        title: title,
        description: description,
        id: null,
        monday: monDayChecked ? 1 : 0,
        tuesday: tuesDayChecked ? 1 : 0,
        wednesday: wednesDayChecked ? 1 : 0,
        thursday: thursDayChecked ? 1 : 0,
        friday: friDayChecked ? 1 : 0,
        saturday: saturDayChecked ? 1 : 0,
        sunday: sunDayChecked ? 1 : 0,
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
