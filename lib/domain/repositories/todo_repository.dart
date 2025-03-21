import 'package:teste_smartfit/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos(int limit);
}
