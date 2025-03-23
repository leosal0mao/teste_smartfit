import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class CreateTodoUsecase {
  final TodoRepository repository;

  CreateTodoUsecase(this.repository);

  Future<Todo> call(Todo todo) async {
    return await repository.createTodo(todo);
  }
}
