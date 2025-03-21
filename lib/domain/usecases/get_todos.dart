import 'package:teste_smartfit/domain/repositories/todo_repository.dart';

import '../entities/todo.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Future<List<Todo>> call(int limit) async {
    return await repository.getTodos(limit);
  }
}
