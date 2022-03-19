import 'package:flutter/material.dart';
import 'package:flutter_festival_ktm/data/models/todo/todo.dart';

class TodoView extends StatelessWidget {
  const TodoView({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Detail')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const Divider(),
                Text(todo.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
