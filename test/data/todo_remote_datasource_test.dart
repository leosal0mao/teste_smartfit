import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:teste_smartfit/core/errors/server_exception.dart';
import 'package:teste_smartfit/data/datasources/implementations/todo_remote_datasource_impl.dart';
import 'package:teste_smartfit/data/datasources/todo_remote_datasource.dart';
import 'package:teste_smartfit/data/models/response_models/todo_list_response_model.dart';
import 'package:teste_smartfit/data/models/response_models/todo_response_model.dart';
import 'package:teste_smartfit/data/models/todo_model.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late TodoRemoteDataSource dataSource;
  late MockDioAdapter mockDioAdapter;

  setUp(() {
    mockDioAdapter = MockDioAdapter();
    dataSource = TodoRemoteDataSourceImpl(dioAdapter: mockDioAdapter);
  });

  group('getTodos', () {
    test('returns TodoListResponseModel when request is successful', () async {
      when(mockDioAdapter.get(
        '/todos',
        queryParameters: {'limit': 2},
      )).thenAnswer((_) async => {
            'todos': [
              {'id': 1, 'todo': 'Test 1', 'completed': false, 'userId': 1},
              {'id': 2, 'todo': 'Test 2', 'completed': true, 'userId': 1}
            ],
            'total': 2,
            'skip': 0,
            'limit': 2
          });

      final result = await dataSource.getTodos(2);

      expect(result, isA<TodoListResponseModel>());
      expect(result.todos.length, 2);
      expect(result.todos[0].id, 1);
      expect(result.todos[1].todo, 'Test 2');

      verify(mockDioAdapter.get(
        '/todos',
        queryParameters: {'limit': 2},
      )).called(1);
    });

    test('throws Exception on timeout', () async {
      when(mockDioAdapter.get(
        '/todos',
        queryParameters: {'limit': 2},
      )).thenThrow(ServerException(message: 'Request timed out'));

      expect(() => dataSource.getTodos(2), throwsA(isA<Exception>()));
    });

    test('throws Exception on server error', () async {
      when(mockDioAdapter.get(
        '/todos',
        queryParameters: {'limit': 2},
      )).thenThrow(ServerException(message: 'Internal Server Error'));

      expect(() => dataSource.getTodos(2), throwsA(isA<Exception>()));
    });
  });

  group('updateTodo', () {
    test('sends correct data and returns updated Todo', () async {
      final todoToUpdate =
          TodoModel(id: 1, todo: 'Updated', completed: true, userId: 1);

      when(mockDioAdapter.put(
        '/todos/1',
        data: todoToUpdate.toJson(),
      )).thenAnswer((_) async =>
          {'id': 1, 'todo': 'Updated', 'completed': true, 'userId': 1});

      final result = await dataSource.updateTodo(todoToUpdate, 1);

      expect(result, isA<TodoResponseModel>());
      expect(result.todo.todo, 'Updated');
      expect(result.todo.completed, true);

      verify(mockDioAdapter.put(
        '/todos/1',
        data: {'id': 1, 'todo': 'Updated', 'completed': true, 'userId': 1},
      )).called(1);
    });
  });

  group('createTodo', () {
    test('sends correct data and returns created Todo', () async {
      final newTodo =
          TodoModel(id: 1, todo: 'New Todo', completed: false, userId: 1);

      when(mockDioAdapter.post(
        '/todos/add',
        data: {
          'id': newTodo.id,
          'todo': newTodo.todo,
          'completed': newTodo.completed,
          'userId': newTodo.userId
        },
      )).thenAnswer((_) async =>
          {'id': 101, 'todo': 'New Todo', 'completed': false, 'userId': 1});

      final result = await dataSource.createTodo(newTodo);

      expect(result, isA<TodoResponseModel>());
      expect(result.todo.id, 101);
      expect(result.todo.todo, 'New Todo');

      verify(mockDioAdapter.post(
        '/todos/add',
        data: {'id': 1, 'todo': 'New Todo', 'completed': false, 'userId': 1},
      )).called(1);
    });
  });

  group('deleteTodo', () {
    test('sends delete request successfully', () async {
      when(mockDioAdapter.delete('/todos/1')).thenAnswer((_) async => {});

      await dataSource.deleteTodo(1);

      verify(mockDioAdapter.delete('/todos/1')).called(1);
    });

    test('throws Exception on delete failure', () async {
      when(mockDioAdapter.delete('/todos/1'))
          .thenThrow(ServerException(message: 'Delete failed'));

      expect(() => dataSource.deleteTodo(1), throwsA(isA<Exception>()));
    });
  });
}
