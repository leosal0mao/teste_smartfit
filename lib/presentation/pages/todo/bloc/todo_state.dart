part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List<TodoModel> todos;

  const TodosLoaded({required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodoOperationSuccess extends TodoState {
  final TodoModel todo;

  const TodoOperationSuccess({required this.todo});

  @override
  List<Object> get props => [todo];
}

class TodoError extends TodoState {
  final String message;

  const TodoError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
