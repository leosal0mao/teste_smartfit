import 'dart:convert';

import '../../../core/network/dio_adapter.dart';
import '../../models/response_models/todo_list_response_model.dart';
import '../../models/response_models/todo_response_model.dart';
import '../../models/todo_model.dart';
import '../todo_remote_datasource.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final DioAdapter dioAdapter;

  TodoRemoteDataSourceImpl({required this.dioAdapter});

  @override
  Future<TodoListResponseModel> getTodos(int limit) async {
    try {
      final response = await dioAdapter.get(
        '/todos',
        queryParameters: {'limit': limit},
      );
      return TodoListResponseModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  @override
  Future<void> deleteTodo(int todoId) async {
    try {
      await dioAdapter.delete('/todos/$todoId');
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }

  @override
  Future<TodoResponseModel> updateTodo(TodoModel todo, int todoId) async {
    try {
      final response = await dioAdapter.put(
        '/todos/$todoId',
        data: todo.toJson(),
      );
      return TodoResponseModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  @override
  Future<TodoResponseModel> createTodo(TodoResponseModel todo) async {
    try {
      final response = await dioAdapter.post(
        '/todos/add',
        data: todo.todo.toJson(),
      );
      return TodoResponseModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create todo: $e');
    }
  }
}
