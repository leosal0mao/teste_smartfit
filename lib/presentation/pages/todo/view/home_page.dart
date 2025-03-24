import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_smartfit/data/models/todo_model.dart';
import 'package:teste_smartfit/presentation/utils/widgets/custom_textfield.dart';

import '../../../theme/app_colors.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/todo_item_widget.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late TodoBloc _todoBloc;
//   @override
//   void initState() {
//     super.initState();
//     _todoBloc = context.read<TodoBloc>();
//     _todoBloc.add(const FetchTodos(limit: 5));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TodoBloc, TodoState>(
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(title: const Text('Todos')),
//           body: BlocBuilder<TodoBloc, TodoState>(
//             builder: (context, state) {
//               if (state is TodoLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is TodosLoaded) {
//                 return ListView.builder(
//                   itemCount: state.todos.length,
//                   itemBuilder: (context, index) {
//                     final todo = state.todos[index];
//                     return ListTile(
//                       title: Text(todo.todo),
//                       subtitle: Text('Completed: ${todo.completed}'),
//                     );
//                   },
//                 );
//               } else if (state is TodoError) {
//                 return Center(child: Text(state.message));
//               }
//               return const Center(child: Text('No todos found'));
//             },
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               // context.read<TodoBloc>().add(
//               //       CreateTodo(
//               //         todo: TodoResponseModel(
//               //           todo: TodoModel(
//               //             id: 1,
//               //             todo: 'New Todo',
//               //             completed: false,
//               //             userId: 1,
//               //           ),
//               //         ),
//               //       ),
//               //     );

//               // context.read<TodoBloc>().add(
//               //       UpdateTodo(
//               //         todoId: 1,
//               //         todo: TodoModel(
//               //           id: 1,
//               //           todo: 'update todo',
//               //           completed: false,
//               //           userId: 152,
//               //         ),
//               //       ),
//               //     );

//               // context.read<TodoBloc>().add(
//               //       DeleteTodo(
//               //         todoId: 1,
//               //       ),
//               //     );
//             },
//             child: const Icon(Icons.add),
//           ),
//         );
//       },
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  late TodoBloc _todoBloc;
  List<TodoModel> _todoList = [];

  @override
  void initState() {
    super.initState();
    _todoBloc = context.read<TodoBloc>();
    _todoBloc.add(const FetchTodos(limit: 7));
  }

  void _addTodoItem() {
    final String text = _textController.text.trim();
    if (text.isNotEmpty) {
      _textController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
              onSubmitted: (value) => _addTodoItem(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoList({required bool completed}) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodoError) {
          return Center(child: Text(state.message));
        } else if (state is TodosLoaded) {
          _todoList =
              state.todos.where((todo) => todo.completed == completed).toList();
          if (_todoList.isEmpty) {
            return Center(
              child: Text(
                completed ? 'No completed todos found' : 'No todos found',
                style: const TextStyle(color: AppColors.white),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: _todoList
                .map((todo) => TodoItem(
                      id: todo.id.toString(),
                      title: todo.todo,
                      onTap: () => Navigator.of(context).pushNamed(
                        '/todo',
                        arguments: todo,
                      ),
                      onDismissed: (direction) {
                        context
                            .read<TodoBloc>()
                            .add(DeleteTodo(todoId: todo.id));
                      },
                    ))
                .toList(),
          );
        }
        return const Center(
          child: Text(
            'No todos found',
            style: TextStyle(color: AppColors.white),
          ),
        );
      },
    );
  }
}
