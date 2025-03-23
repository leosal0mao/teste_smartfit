import 'package:teste_smartfit/domain/repositories/todo_repository.dart';

import '../entities/todo.dart';

class GetTodosUsecase {
  final TodoRepository repository;

  GetTodosUsecase(this.repository);

  Future<List<Todo>> call(int limit) async {
    return await repository.getTodos(limit);
  }
}
