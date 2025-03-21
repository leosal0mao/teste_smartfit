// repositories/todo_repository_impl.dart
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_remote_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Todo>> getTodos(int limit) async {
    final response = await remoteDataSource.getTodos(limit);
    return response.todos.map((todo) => todo.toEntity()).toList();
  }
}
