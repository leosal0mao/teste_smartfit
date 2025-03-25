// test/domain/repositories/todo_repository_impl_test.dart
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:teste_smartfit/data/models/response_models/todo_list_response_model.dart';
import 'package:teste_smartfit/data/models/response_models/todo_response_model.dart';
import 'package:teste_smartfit/data/models/todo_model.dart';
import 'package:teste_smartfit/data/repositories/todo_repository_impl.dart';
import 'package:teste_smartfit/domain/entities/todo.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late TodoRepositoryImpl repository;
  late MockTodoRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTodoRemoteDataSource();
    repository = TodoRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getTodos', () {
    test('should return list of Todos when successful', () async {
      // Arrange
      final todoModels = [
        TodoModel(id: 1, todo: 'Test 1', completed: false, userId: 1),
        TodoModel(id: 2, todo: 'Test 2', completed: true, userId: 1),
      ];
      final response = TodoListResponseModel(
        todos: todoModels,
      );

      when(mockRemoteDataSource.getTodos(10)).thenAnswer((_) async => response);

      // Act
      final result = await repository.getTodos(10);

      // Assert
      expect(result, isA<List<Todo>>());
      expect(result.length, 2);
      verify(mockRemoteDataSource.getTodos(10)).called(1);
    });
  });

  group('updateTodo', () {
    test('should return updated Todo when successful', () async {
      // Arrange
      final todoEntity = Todo(
        id: 1,
        todo: 'Updated Todo',
        completed: true,
        userId: 1,
      );
      final todoModel = TodoModel.fromEntity(todoEntity);
      final response = TodoResponseModel(todo: todoModel);

      when(mockRemoteDataSource.updateTodo(todoModel, 1))
          .thenAnswer((_) async => response);

      // Act
      final result = await repository.updateTodo(1, todoEntity);

      // Assert
      expect(result, isA<Todo>());
      expect(result.todo, 'Updated Todo');
      verify(mockRemoteDataSource.updateTodo(todoModel, 1)).called(1);
    });
  });

  group('createTodo', () {
    test('should return created Todo when successful', () async {
      // Arrange
      final todoEntity = Todo(
        id: 1,
        todo: 'New Todo',
        completed: false,
        userId: 1,
      );
      final todoModel = TodoModel.fromEntity(todoEntity);
      final createdTodo = TodoModel(
        id: 101,
        todo: 'New Todo',
        completed: false,
        userId: 1,
      );
      final response = TodoResponseModel(todo: createdTodo);

      when(mockRemoteDataSource.createTodo(todoModel))
          .thenAnswer((_) async => response);

      // Act
      final result = await repository.createTodo(todoEntity);

      // Assert
      expect(result.id, 101);
      verify(mockRemoteDataSource.createTodo(todoModel)).called(1);
    });
  });

  group('deleteTodo', () {
    test('should complete when successful', () async {
      // Arrange
      when(mockRemoteDataSource.deleteTodo(1)).thenAnswer((_) async {});

      // Act
      await repository.deleteTodo(1);

      // Assert
      verify(mockRemoteDataSource.deleteTodo(1)).called(1);
    });
  });
}
