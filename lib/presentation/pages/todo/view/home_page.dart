import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_smartfit/data/models/todo_model.dart';
import 'package:teste_smartfit/presentation/utils/widgets/custom_textfield.dart';

import '../../../theme/app_colors.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/todo_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(const FetchTodos(limit: 7));
  }

  void _addTodoItem() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      final currentState = context.read<TodoBloc>().state;
      final todos = currentState is TodosLoaded ? currentState.todos : [];

      context.read<TodoBloc>().add(
            CreateTodo(
              todo: TodoModel(
                id: todos.length + 1,
                todo: text,
                completed: false,
                userId: 1,
              ),
            ),
          );
      _textController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.themeColor,
          appBar: AppBar(
            title: const Text('To Do List'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'TO DO'),
                Tab(text: 'COMPLETED'),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTodoList(completed: false),
                    _buildTodoList(completed: true),
                  ],
                ),
              ),
              CustomTextField(
                textController: _textController,
                onPressed: _addTodoItem,
                onSubmitted: (_) => _addTodoItem(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodoList({required bool completed}) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        final todos = state is TodosLoaded ? state.todos : [];
        final filteredTodos =
            todos.where((t) => t.completed == completed).toList();

        if (state is TodoLoading && todos.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodoError) {
          return Center(child: Text(state.message));
        } else if (filteredTodos.isEmpty) {
          return Center(
            child: Text(
              completed ? 'No completed todos' : 'No todos yet',
              style: const TextStyle(color: AppColors.white),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredTodos.length,
          itemBuilder: (ctx, index) => TodoItem(
            isCompleted: filteredTodos[index].completed,
            id: filteredTodos[index].id.toString(),
            title: filteredTodos[index].todo,
            onTap: () => Navigator.pushNamed(
              ctx,
              '/todo',
              arguments: filteredTodos[index],
            ),
            onDismissed: (direction) {
              context.read<TodoBloc>().add(
                    DeleteTodo(todo: filteredTodos[index]),
                  );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('TODO #${filteredTodos[index].id} deleted.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            onCompletedChanged: (value) {
              if (value != null) {
                context.read<TodoBloc>().add(
                      UpdateTodo(
                        todo: filteredTodos[index].copyWith(completed: value),
                        todoId: filteredTodos[index].id,
                      ),
                    );
              }
            },
          ),
        );
      },
    );
  }
}
