import '../todo_model.dart';

class TodoResponseModel {
  final List<TodoModel> todos;
  final int total;
  final int skip;
  final int limit;

  TodoResponseModel({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TodoResponseModel.fromJson(Map<String, dynamic> json) {
    return TodoResponseModel(
      todos: (json['todos'] as List)
          .map((todo) => TodoModel.fromJson(todo))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
