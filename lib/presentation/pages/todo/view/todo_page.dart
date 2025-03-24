import 'package:flutter/material.dart';
import '../../../../data/models/todo_model.dart';
import '../../../theme/app_colors.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late TodoModel _todo;
  final TextEditingController _textController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();

  //   _textController.text =
  //       _todo.todo; // Preenche o TextField com o texto da tarefa
  // }

  @override
  Widget build(BuildContext context) {
    _todo = ModalRoute.of(context)!.settings.arguments as TodoModel;
    _textController.text = _todo.todo;
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      appBar: AppBar(
        title: Text('TO DO ID: ${_todo.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título "TODO DETAILS"
            const Text(
              'TODO DETAILS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 16), // Espaçamento

            // TextField com bordas arredondadas
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
            const SizedBox(height: 24), // Espaçamento

            // Botões
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para marcar a tarefa como concluída
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        'Complete Task',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),

                    // Botão "Delete Task"
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para deletar a tarefa
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
                // Botão "Complete Task"

                // Botão "Edit Task"
                ElevatedButton(
                  onPressed: () {
                    // Lógica para editar a tarefa
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
                    'Edit Task',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
