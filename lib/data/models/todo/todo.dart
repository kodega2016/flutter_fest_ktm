import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    required String id,
    required String userId,
    required String title,
    required String description,
    @Default(false) bool isComplete,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
