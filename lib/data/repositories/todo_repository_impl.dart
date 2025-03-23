import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_remote_datasource.dart';
import '../models/response_models/todo_response_model.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Todo>> getTodos(int limit) async {
    final response = await remoteDataSource.getTodos(limit);
    return response.toEntityList();
  }

  @override
  Future<void> deleteTodo(int todoId) async {
    await remoteDataSource.deleteTodo(todoId);
  }

  @override
  Future<Todo> updateTodo(int todoId, Todo todo) async {
    final todoModel = TodoModel.fromEntity(todo);

    final updatedTodoResponse =
        await remoteDataSource.updateTodo(todoModel, todoId);

    return updatedTodoResponse.toEntity();
  }

  @override
  Future<Todo> createTodo(Todo todo) async {
    final todoModel = TodoModel.fromEntity(todo);

    final todoResponseModel = TodoResponseModel(todo: todoModel);

    final createdTodoResponse =
        await remoteDataSource.createTodo(todoResponseModel);

    return createdTodoResponse.todo.toEntity();
  }
}
