import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangeDescription;
  final VoidCallback onSavedTodo;
  final VoidCallback onCancel;

  // final VoidCallback onTapDate;
  // final TextEditingController dateController;

  const TodoFormWidget({
    Key key,
    this.title = '',
    this.description = '',
    @required this.onChangedTitle,
    @required this.onChangeDescription,
    @required this.onSavedTodo,
    @required this.onCancel,
    // @required this.onTapDate,
    //   @required this.dateController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          SizedBox(
            height: 10,
          ),
          buildDescription(),
          // SizedBox(height: 20,),
          // buildDate(),
          SizedBox(
            height: 20,
          ),
          buildButton(),
          SizedBox(
            height: 20,
          ),
          cancelButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      onChanged: onChangedTitle,
      validator: (title) {
        if (title.isEmpty) {
          return '※タイトルは必須';
        }
        return null;
      },
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'タイトル',
      ),
    );
  }

  Widget buildDescription() {
    return TextFormField(
      maxLines: 3,
      initialValue: description,
      onChanged: onChangeDescription,
      validator: (description) {
        return null;
      },
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: '説明',
      ),
    );
  }

  // Widget buildDate() {
  //   return TextFormField(
  //     controller: dateController,
  //     onTap: onTapDate,
  //     validator: (date){
  //       if(date.isEmpty){
  //         return 'The Date cannot be empty';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //         labelText: '日付',
  //         hintText: 'タスクする日付を選択',
  //         prefixIcon: Icon(Icons.calendar_today),
  //
  //     ),
  //   );
  // }

  buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: onSavedTodo,
        child: Text('追加'),
      ),
    );
  }

  cancelButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: onCancel,
        child: Text('キャンセル'),
      ),
    );
  }
}
