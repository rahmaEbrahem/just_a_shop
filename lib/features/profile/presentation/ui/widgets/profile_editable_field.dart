import 'package:flutter/material.dart';

class ProfileEditableField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isEditing;
  final VoidCallback onToggleEdit;

  const ProfileEditableField({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.isEditing,
    required this.onToggleEdit,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        readOnly: !isEditing,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: isEditing
              ? primaryColor.withValues(alpha: 0.08)
              : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isEditing ? Icons.check_circle_outline : Icons.edit_outlined,
              color: isEditing ? primaryColor : null,
            ),
            onPressed: onToggleEdit,
          ),
        ),
      ),
    );
  }
}