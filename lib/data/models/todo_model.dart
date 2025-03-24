import '../../domain/entities/todo.dart';

class TodoModel {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  TodoModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  Todo toEntity() {
    return Todo(
      id: id,
      todo: todo,
      completed: completed,
      userId: userId,
    );
  }

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      id: todo.id,
      todo: todo.todo,
      completed: todo.completed,
      userId: todo.userId,
    );
  }
}
