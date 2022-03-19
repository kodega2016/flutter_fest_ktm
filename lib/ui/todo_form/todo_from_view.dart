import 'package:flutter/material.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/data/models/todo/todo.dart';
import 'package:flutter_festival_ktm/ui/todo_form/todo_form_view_model.dart';
import 'package:flutter_festival_ktm/widgets/p_elevated_button.dart';
import 'package:stacked/stacked.dart';

class TodoFormView extends StatelessWidget {
  const TodoFormView({
    Key? key,
    this.todo,
  }) : super(key: key);

  final Todo? todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: ViewModelBuilder<TodoFormViewModel>.reactive(
        onModelReady: (model) => model.init(todo),
        viewModelBuilder: () => locator<TodoFormViewModel>(),
        builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: model.title,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onChanged: model.changeTitle,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextFormField(
                      maxLines: 4,
                      initialValue: model.description,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onChanged: model.changeDescription,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Status'),
                      value: model.isCompleted,
                      onChanged: model.changeStatus,
                    ),
                    const SizedBox(height: 10),
                    PElevatedButton(
                      isBusy: model.busy(TodoFormViewModel.saving),
                      onPressed: () async => await model.save(),
                      label: 'Save',
                      disable: !model.isFormValid,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
