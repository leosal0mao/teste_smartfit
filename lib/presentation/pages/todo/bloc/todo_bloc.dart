import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/datasources/todo_remote_datasource.dart';
import '../../../../data/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRemoteDataSource remoteDataSource;
  List<TodoModel> _todos = [];

  TodoBloc({required this.remoteDataSource}) : super(TodoInitial()) {
    on<FetchTodos>(_onFetchTodos);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<CreateTodo>(_onCreateTodo);
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final response = await remoteDataSource.getTodos(event.limit);
      _todos = response.todos;
      emit(TodosLoaded(todos: _todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      // Persistir na API
      // await remoteDataSource.deleteTodo(event.todoId);
      _todos.removeWhere((todo) => todo.id == event.todo.id);
      emit(TodoOperationSuccess(todo: event.todo));
      emit(TodosLoaded(todos: _todos));
    } catch (e) {
      emit(TodoError(message: 'Falha ao deletar: ${e.toString()}'));

      emit(TodosLoaded(todos: _todos));
    }
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      // Persistir na API
      // final response = await remoteDataSource.updateTodo(event.todo, event.todoId);
      // _todos[index] = response.todo;
      // emit(TodosLoaded(todos: List.from(_todos)));

      final index = _todos.indexWhere((t) => t.id == event.todoId);
      if (index != -1) {
        _todos[index] = event.todo;
        emit(TodoOperationSuccess(todo: event.todo));
        emit(TodosLoaded(todos: List.from(_todos)));
      }
    } catch (e) {
      emit(TodoError(message: e.toString()));
      emit(TodosLoaded(todos: List.from(_todos)));
    }
  }

  Future<void> _onCreateTodo(CreateTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      //Persistir na API
      // final response = await remoteDataSource.createTodo(event.todo);
      _todos.add(event.todo);
      emit(TodoOperationSuccess(todo: event.todo));
      emit(TodosLoaded(todos: _todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }
}
