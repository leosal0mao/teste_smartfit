import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:teste_smartfit/data/datasources/todo_remote_datasource.dart';
import 'package:teste_smartfit/data/models/response_models/todo_response_model.dart';
import 'package:teste_smartfit/data/models/todo_model.dart';
import 'package:teste_smartfit/data/repositories/todo_repository_impl.dart';
import 'package:teste_smartfit/domain/entities/todo.dart';

class MockTodoRemoteDataSource extends Mock implements TodoRemoteDataSource {}

void main() {
  late TodoRepositoryImpl repository;
  late MockTodoRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTodoRemoteDataSource();
    repository = TodoRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  test('should update a todo and return the updated todo entity', () async {
    // Arrange
    const todoId = 1;
    final todo = Todo(
      id: todoId,
      todo: 'Updated Todo',
      completed: true,
      userId: 1,
    );

    final todoModel = TodoModel.fromEntity(todo);
    final todoUpdateResponseModel = TodoResponseModel(todo: todoModel);

    when(mockRemoteDataSource.updateTodo(todoModel, todoId))
        .thenAnswer((_) async => todoUpdateResponseModel);

    // Act
    final result = await repository.updateTodo(todoId, todo);

    // Assert
    expect(result, todo);
    verify(mockRemoteDataSource.updateTodo(todoModel, todoId));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('should throw an exception when the update fails', () async {
    // Arrange
    const todoId = 1;
    final todo = Todo(
      id: todoId,
      todo: 'Updated Todo',
      completed: true,
      userId: 1,
    );

    final todoModel = TodoModel.fromEntity(todo);

    when(mockRemoteDataSource.updateTodo(todoModel, todoId))
        .thenThrow(Exception('Failed to update todo'));

    // Act e Assert
    expect(
        () => repository.updateTodo(todoId, todo), throwsA(isA<Exception>()));
    verify(mockRemoteDataSource.updateTodo(todoModel, todoId));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
