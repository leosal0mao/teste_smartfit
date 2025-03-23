class Todo {
  final int id;
  final int userId;
  final String todo;
  final bool completed;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });
}
