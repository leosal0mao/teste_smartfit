import '../repositories/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository repository;

  DeleteTodoUsecase(this.repository);

  Future<void> call(int todoId) async {
    return await repository.deleteTodo(todoId);
  }
}
