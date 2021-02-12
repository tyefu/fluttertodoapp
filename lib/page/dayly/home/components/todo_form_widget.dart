import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangeDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget(
      {Key key,
      this.title = '',
      this.description = '',
      @required this.onChangedTitle,
      @required this.onChangeDescription,
      @required this.onSavedTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          SizedBox(height: 10,),
          buildDescription(),
          SizedBox(height: 20,),
          buildButton(),
        ],
      ),
    );
  }

 Widget buildTitle() {
   return TextFormField(
      maxLines: 1,
      initialValue: title,
      onChanged: onChangedTitle,
      validator: (title){
        if(title.isEmpty){
          return 'The title cannot be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Title',
      ),
    );
 }
  Widget buildDescription() {
   return TextFormField(
      maxLines: 3,
      initialValue: description,
      onChanged: onChangeDescription,
      validator: (description){
        if(description.isEmpty){
          return 'The description cannot be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Description',
      ),
    );
  }

  buildButton() {
   return  SizedBox(
     width: double.infinity,
     child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
          onPressed: onSavedTodo, child: Text('Save'),),
   );
  }
}
