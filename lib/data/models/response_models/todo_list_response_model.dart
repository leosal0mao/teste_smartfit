import '../../../domain/entities/todo.dart';
import '../todo_model.dart';

class TodoListResponseModel {
  final List<TodoModel> todos;

  TodoListResponseModel({
    required this.todos,
  });

  factory TodoListResponseModel.fromJson(Map<String, dynamic> json) {
    return TodoListResponseModel(
      todos: (json['todos'] as List)
          .map((todo) => TodoModel.fromJson(todo))
          .toList(),
    );
  }

  List<Todo> toEntityList() {
    return todos.map((todo) => todo.toEntity()).toList();
  }
}
