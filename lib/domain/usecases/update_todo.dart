import 'package:teste_smartfit/domain/repositories/todo_repository.dart';

import '../entities/todo.dart';

class UpdateTodoUsecase {
  final TodoRepository repository;

  UpdateTodoUsecase(this.repository);

  Future<Todo> call(int todoId, Todo todo) async {
    return await repository.updateTodo(todoId, todo);
  }
}
