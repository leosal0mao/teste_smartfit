import 'package:teste_smartfit/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos(int limit);
  Future<void> deleteTodo(int todoId);
  Future<Todo> updateTodo(int todoId, Todo todo);
  Future<Todo> createTodo(Todo todo);
}
