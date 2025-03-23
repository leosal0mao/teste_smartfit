import '../../../domain/entities/todo.dart';
import '../todo_model.dart';

class TodoResponseModel {
  final TodoModel todo;

  TodoResponseModel({
    required this.todo,
  });

  factory TodoResponseModel.fromJson(Map<String, dynamic> json) {
    return TodoResponseModel(
      todo: TodoModel.fromJson(json),
    );
  }

  Todo toEntity() {
    return todo.toEntity();
  }
}
