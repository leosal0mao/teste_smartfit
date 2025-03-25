import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final String id;
  final Function(DismissDirection) onDismissed;
  final Function() onTap;
  final Function(bool?) onCompletedChanged;

  const TodoItem({
    super.key,
    required this.title,
    required this.id,
    required this.onDismissed,
    required this.onTap,
    required this.onCompletedChanged,
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
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
          trailing: Checkbox(
              tristate: true,
              value: isCompleted,
              onChanged: onCompletedChanged,
              checkColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              side: const BorderSide(color: AppColors.white),
              fillColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return AppColors.white;
                }
                return AppColors.white;
              })),
        ),
      ),
    );
  }
}
