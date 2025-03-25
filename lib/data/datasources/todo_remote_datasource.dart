import '../models/response_models/todo_list_response_model.dart';
import '../models/response_models/todo_response_model.dart';
import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<TodoListResponseModel> getTodos(int limit);
  Future<void> deleteTodo(int todoId);
  Future<TodoResponseModel> updateTodo(TodoModel todo, int todoId);
  Future<TodoResponseModel> createTodo(TodoModel todo);
}
