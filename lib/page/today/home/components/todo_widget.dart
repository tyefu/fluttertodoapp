import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:flutter_app_todo_app/page/today/edit/edit_todo_page.dart';
import 'package:flutter_app_todo_app/utils/database_helper.dart';
import 'package:flutter_app_todo_app/utils/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;

  const TodoWidget({Key key, @required this.todo}) : super(key: key);

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  DatabaseHelper _dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notificationPlugIn.showNotification();
    setState(() {
      _dbHelper = DatabaseHelper.instance;

    });
    // refreshTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(widget.todo.id.toString()),
          actions: [
            IconSlideAction(
              icon: Icons.edit,
              color: Colors.green,
              onTap: () {
                editTodo(context, widget.todo);
              },
              caption: '編集',
            ),
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: '削除',
              onTap: () async {
                await deleteTodo(context, widget.todo);
                // refreshTodoList();
              },
              icon: Icons.delete,
            ),
          ],
          child: buildTodo(context)),
    );
  }

  // refreshTodoList() async {
  //   final provider = Provider.of<TodosProvider>(context,listen: false);
  //   List<Todo> x = await _dbHelper.fetchTodos();
  //
  //     provider.todos = x.where((todo) => todo.isDone == 0).toList();
  //     _todos = provider.todos;
  //
  //
  //
  // }
  Widget buildTodo(BuildContext context) {
    return GestureDetector(
      onTap: () => editTodo(context, widget.todo),
      child: PhysicalModel(
        color: Colors.pink.shade50,
        elevation: 8.0,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              PhysicalModel(
                color: Colors.pink.shade50,
                shadowColor: Colors.pink.shade700,
                elevation: 20.0,
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.pink,
                  ),
                  child: Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: Colors.white,
                      value: widget.todo.isDone == 0 ? false : true,
                      onChanged: (_) async {
                        final provider =
                            Provider.of<TodosProvider>(context, listen: false);
                        final isDone = provider.toggleTodoStatus(widget.todo);

                        await _dbHelper.updateTodo(widget.todo);
                        Utils.showSnackBar(
                            context,
                            isDone == 1
                                ? '${widget.todo.title}タスク完了!'
                                : '${widget.todo.title}タスク未完了!');
                      }),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                    ),
                  ),
                  if (widget.todo.description.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        widget.todo.description,
                        style: TextStyle(fontSize: 12, height: 1.5),
                      ),
                    ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteTodo(BuildContext context, Todo todo) async {
    print('----------------');
    await _dbHelper.deleteTodo(todo.id);

    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);
    print('----------------');
    Utils.showSnackBar(context, "${todo.title}タスクを削除しました!");
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditTodoPage(todo: todo),
    ));
  }
}
