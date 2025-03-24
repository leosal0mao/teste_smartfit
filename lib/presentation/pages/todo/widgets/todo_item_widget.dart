import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final String id;
  final Function(DismissDirection) onDismissed;
  final Function() onTap;

  const TodoItem({
    super.key,
    required this.title,
    required this.id,
    required this.onDismissed,
    required this.onTap,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: onDismissed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.themeLighterColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text(
            title,
            style: const TextStyle(color: AppColors.white),
          ),
          trailing: isCompleted
              ? const Icon(Icons.check_circle, color: AppColors.green)
              : const Icon(Icons.check_circle, color: AppColors.white),
        ),
      ),
    );
  }
}
