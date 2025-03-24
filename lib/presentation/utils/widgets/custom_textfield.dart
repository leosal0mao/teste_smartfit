import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) onSubmitted;
  final VoidCallback onPressed;
  const CustomTextField({
    super.key,
    required this.textController,
    required this.onSubmitted,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: AppColors.themeLighterColor,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              style: const TextStyle(color: AppColors.white),
              decoration: const InputDecoration(
                hintText: 'Add item...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              ),
              onSubmitted: (value) => onSubmitted,
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.green),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
