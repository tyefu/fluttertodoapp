import 'package:flutter/cupertino.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  static const TODOTABLE = 'todoTable';
  static const ID = 'id';
  static const TITLE = 'title';
  static const DESCRIPTION = 'description';
  static const CREATEDTIME = 'createdTime';
  static const ISDONE = 'isDone';
  static const MONDAY = 'monday';
  static const TUESDAY = 'tuesday';
  static const WEDNESDAY = 'wednesday';
  static const THURSDAY = 'thursday';
  static const FRIDAY = 'friday';
  static const SATURDAY = 'saturday';
  static const SUNDAY = 'sunday';
   int id;
   String title;
   String description;
   String createdTime;
   int isDone;
   int monday;
   int tuesday;
   int wednesday;
   int thursday;
   int friday;
   int saturday;
   int sunday;

  Todo({
    @required this.createdTime,
    @required this.title,
    this.description = '',
    this.id,
    this.isDone = 0,
    this.monday = 0,
    this.tuesday = 0,
    this.wednesday = 0,
    this.thursday = 0,
    this.friday = 0,
    this.saturday = 0,
    this.sunday = 0,
  });

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[ID];
    title = map[TITLE];
    description = map[DESCRIPTION];
    createdTime = map[CREATEDTIME];
    isDone = map[ISDONE];
    monday = map[MONDAY];
    tuesday = map[TUESDAY];
    wednesday = map[WEDNESDAY];
    thursday = map[THURSDAY];
    friday = map[FRIDAY];
    saturday = map[SATURDAY];
    sunday = map[SUNDAY];
  }

  //
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map[ID] = id;
    map[TITLE] = title;
    map[DESCRIPTION] = description;
    map[CREATEDTIME] = createdTime;
    map[ISDONE] = isDone;
    map[MONDAY] = monday;
    map[TUESDAY] = tuesday;
    map[WEDNESDAY] = wednesday;
    map[THURSDAY] = thursday;
    map[FRIDAY] = friday;
    map[SATURDAY] = saturday;
    map[SUNDAY] = sunday;
    return map;
  }
}
