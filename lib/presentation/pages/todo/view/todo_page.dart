import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/todo_model.dart';
import '../../../theme/app_colors.dart';
import '../bloc/todo_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late TodoModel _todo;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _todo = ModalRoute.of(context)!.settings.arguments as TodoModel;
    _textController.text = _todo.todo;

    return Scaffold(
      backgroundColor: AppColors.themeColor,
      appBar: AppBar(
        title: Text('TO DO ID: ${_todo.id}'),
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          // if (state is TodoEditionSuccess) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('TODO edited successfully!'),
          //       backgroundColor: Colors.green,
          //     ),
          //   );
          //   Navigator.pop(context, true);
          // }
          if (state is TodoOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('TODO operation completed successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true); // Retorna com sucesso
          } else if (state is TodoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'TODO DETAILS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _textController,
                maxLines: 8,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.themeLighterColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16.0),
                ),
                style: const TextStyle(color: AppColors.white),
              ),
              const SizedBox(height: 24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final updatedTodo = _todo.copyWith(
                            completed: !_todo.completed,
                          );
                          context.read<TodoBloc>().add(
                                UpdateTodo(
                                  todo: updatedTodo,
                                  todoId: _todo.id,
                                ),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          _todo.completed ? 'Mark Incomplete' : 'Complete Task',
                          style: const TextStyle(color: AppColors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<TodoBloc>().add(
                                DeleteTodo(todo: _todo),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Delete Task',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final updatedTodo = _todo.copyWith(
                        todo: _textController.text,
                      );
                      context.read<TodoBloc>().add(
                            UpdateTodo(
                              todo: updatedTodo,
                              todoId: _todo.id,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
