import 'package:flutter/material.dart';

class WeekCheckBox extends StatelessWidget {
  final ValueChanged<bool> onChangedCheck;
  final bool dayOfTheWeekChecked;
  final String dayOfTheWeekTitle;

  const WeekCheckBox(
      {Key key,
      @required this.onChangedCheck,
      this.dayOfTheWeekChecked = false,
      @required this.dayOfTheWeekTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          children: [
            Text(
              dayOfTheWeekTitle,
              style: TextStyle(color: Colors.pink),
            ),
            Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.pink,
              ),
              child: Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: dayOfTheWeekChecked,
                onChanged: onChangedCheck,
              ),
            )
          ],
        ),
      ],
    );
  }
}
