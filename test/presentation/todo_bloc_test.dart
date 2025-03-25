// test/presentation/bloc/todo_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:teste_smartfit/data/models/response_models/todo_list_response_model.dart';
import 'package:teste_smartfit/data/models/todo_model.dart';
import 'package:teste_smartfit/presentation/pages/todo/bloc/todo_bloc.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late TodoBloc bloc;
  late MockTodoRemoteDataSource mockRemoteDataSource;
  final mockTodo = TodoModel(id: 1, todo: 'Test', completed: false, userId: 1);

  setUp(() {
    mockRemoteDataSource = MockTodoRemoteDataSource();
    bloc = TodoBloc(remoteDataSource: mockRemoteDataSource);
  });

  Future<void> initializeWithTodos(List<TodoModel> todos) async {
    when(mockRemoteDataSource.getTodos(any))
        .thenAnswer((_) async => TodoListResponseModel(
              todos: todos,
            ));
    bloc.add(const FetchTodos(limit: 10));
    await bloc.stream.firstWhere((state) => state is TodosLoaded);
  }

  group('DeleteTodo', () {
    blocTest<TodoBloc, TodoState>(
      'should emit correct states when deleting',
      build: () => bloc,
      setUp: () async => await initializeWithTodos([mockTodo]),
      act: (bloc) => bloc.add(DeleteTodo(todo: mockTodo)),
      expect: () => [
        TodoLoading(),
        TodoOperationSuccess(todo: mockTodo),
        const TodosLoaded(todos: []),
      ],
    );
  });

  group('UpdateTodo', () {
    final updatedTodo = mockTodo.copyWith(completed: true);

    blocTest<TodoBloc, TodoState>(
      'should emit correct states when updating',
      build: () => bloc,
      setUp: () async => await initializeWithTodos([mockTodo]),
      act: (bloc) => bloc.add(UpdateTodo(todoId: 1, todo: updatedTodo)),
      expect: () => [
        TodoLoading(),
        TodoOperationSuccess(todo: updatedTodo),
        TodosLoaded(todos: [updatedTodo]),
      ],
    );
  });
}
