import 'package:teste_smartfit/domain/entities/todo.dart';

class TodoModel {
  final String id;
  final String todo;
  final bool completed;

  TodoModel({required this.id, required this.todo, required this.completed});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }

  Todo toEntity() => Todo(
        id: id,
        todo: todo,
        completed: completed,
      );
}
