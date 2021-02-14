import 'package:flutter/material.dart';
import 'package:flutter_app_todo_app/model/todo.dart';
import 'package:flutter_app_todo_app/page/dayly/provider/todos.dart';
import 'package:provider/provider.dart';


class WeekOfDayList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<WeekOfDayList> {
  List<String> categories = [
    "月曜日","火曜日","水曜日","木曜日","金曜日","土曜日","日曜日"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20/2),
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context,index) => buildCategory(index, context)),
    );
  }

  Padding buildCategory(int index, BuildContext context) {
    final provider = Provider.of<TodosProvider>(context,listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child: GestureDetector(
        onTap: (){

          provider.selectedWeekOfDayFunc(index);


            print(provider.selectedWeekOfDay);
        },
        child: Column(
          children: [
            Text(
              categories[index],
              style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w600,
                  color: index == provider.selectedWeekOfDay ? Colors.black : Colors.black.withOpacity(0.4)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: index ==  provider.selectedWeekOfDay ? Colors.pinkAccent : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
