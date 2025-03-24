import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/datasources/todo_remote_datasource.dart';
import '../../../../data/models/response_models/todo_response_model.dart';
import '../../../../data/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRemoteDataSource remoteDataSource;

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
      emit(TodosLoaded(todos: response.todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await remoteDataSource.deleteTodo(event.todoId);
      emit(TodoDeleted());
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final response =
          await remoteDataSource.updateTodo(event.todo, event.todoId);
      emit(TodoOperationSuccess(todo: response.todo));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> _onCreateTodo(CreateTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final response = await remoteDataSource.createTodo(event.todo);
      emit(TodoOperationSuccess(todo: response.todo));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }
}
