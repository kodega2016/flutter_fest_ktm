import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter_festival_ktm/constants/app_collections.dart';
import 'package:flutter_festival_ktm/data/models/todo/todo.dart';

class TodoService {
  final DatabaseService<Todo> todoDB = DatabaseService<Todo>(
    AppCollections.todos,
    fromDS: (id, data) => Todo.fromJson(data!).copyWith(id: id),
    toMap: (children) => children.toJson(),
  );

  Future<void> createOrUpdateTodo(Map<String, dynamic> map, String id) async {
    return await todoDB.create(
      map,
      id: id,
    );
  }

  Future<void> deleteTodo(String id) async {
    await todoDB.removeItem(id);
  }
}
