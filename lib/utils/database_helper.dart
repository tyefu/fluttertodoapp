import 'dart:io';

import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'TodoDatabase.db';
  static const _databaseVersion = 1;

  //singleton class
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    print(dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    //create tables
    await db.execute('''
      CREATE TABLE ${Todo.TODOTABLE}(
        ${Todo.ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Todo.TITLE} TEXT NOT NULL,
        ${Todo.DESCRIPTION} TEXT,
        ${Todo.CREATEDTIME} TEXT NOT NULL,
        ${Todo.ISDONE} INTEGER NOT NULL,
        ${Todo.MONDAY} INTEGER NOT NULL,
        ${Todo.TUESDAY} INTEGER NOT NULL,
        ${Todo.WEDNESDAY} INTEGER NOT NULL,
        ${Todo.THURSDAY} INTEGER NOT NULL,
        ${Todo.FRIDAY} INTEGER NOT NULL,
        ${Todo.SATURDAY} INTEGER NOT NULL,
        ${Todo.SUNDAY} INTEGER NOT NULL
      )
      ''');
  }
  //contact - insert
  Future<int> insertTodo(Todo todo) async {
    Database db = await database;
    return await db.insert(Todo.TODOTABLE, todo.toMap());
  }
//contact - update
  Future<int> updateTodo(Todo todo) async {
    Database db = await database;
    return await db.update(Todo.TODOTABLE, todo.toMap(),
        where: '${Todo.ID}=?', whereArgs: [todo.id]);
  }
  Future<int> updateTodoDone(Todo todo) async {
    Database db = await database;
    return await db.update(Todo.TODOTABLE, todo.toMap(),
        where: '${Todo.ISDONE}=?', whereArgs: [todo.isDone]);
  }
//contact - delete
  Future<int> deleteTodo(int id) async {
    Database db = await database;
    return await db.delete(Todo.TODOTABLE,
        where: '${Todo.ID}=?', whereArgs: [id]);
  }
//contact - retrieve all
  Future<List<Todo>> fetchTodos() async {
    Database db = await database;
    List<Map> todos = await db.query(Todo.TODOTABLE);
    return todos.length == 0
        ? []
        : todos.map((x) => Todo.fromMap(x)).toList();
  }



}