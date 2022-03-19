import 'package:flutter/material.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/ui/todos/todos_view_model.dart';
import 'package:stacked/stacked.dart';

class TodosView extends StatelessWidget {
  const TodosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodosViewModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => locator<TodosViewModel>(),
      builder: (context, model, child) {
        final _todos = model.todos;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Todos'),
            actions: [
              IconButton(
                onPressed: model.logout,
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.small(
            onPressed: model.navigateToTodoForm,
            child: const Icon(Icons.add),
          ),
          body: _todos.isEmpty
              ? const Center(child: Text('No Todos Found.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _todos.length,
                  itemBuilder: (context, i) {
                    final _todo = _todos[i];
                    return Card(
                      color: _todo.isComplete
                          ? Colors.greenAccent
                          : Colors.yellowAccent,
                      child: Dismissible(
                        key: ValueKey(_todo.id),
                        background: Container(color: Colors.red),
                        direction: DismissDirection.endToStart,
                        onDismissed: (dir) async => model.deleteTodo(_todo.id),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              _todo.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              _todo.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () => model.navigateToTodo(todo: _todo),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                model.navigateToTodoForm(todo: _todo);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
