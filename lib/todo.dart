import 'package:flutter/material.dart';
import 'checkbox.dart';

class TodoItem extends StatefulWidget {

  final String name;
  final bool isActive;

  const TodoItem({Key? key, required this.name, required this.isActive,}) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
        width: MediaQuery.of(context).size.width / 100 * 50,
        child: Text(widget.name, style: TextStyle(fontSize: 17, color: Colors.black),),
        ),
        Check(isActive: widget.isActive,)
      ],
      ),
    );
  }
}

