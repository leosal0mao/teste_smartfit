part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class FetchTodos extends TodoEvent {
  final int limit;

  const FetchTodos({required this.limit});

  @override
  List<Object> get props => [limit];
}

class DeleteTodo extends TodoEvent {
  final TodoModel todo;

  const DeleteTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodoEvent {
  final TodoModel todo;
  final int todoId;

  const UpdateTodo({required this.todo, required this.todoId});

  @override
  List<Object> get props => [todo, todoId];
}

class CreateTodo extends TodoEvent {
  final TodoModel todo;

  const CreateTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}
