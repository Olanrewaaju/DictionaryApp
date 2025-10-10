import 'package:flutter/material.dart';

class Fieldfortext extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool autoFocus;
  final FocusNode? focusNode;
  final VoidCallback? onSubmitted;
  const Fieldfortext({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.autoFocus = false,
    this.focusNode,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),

        TextField(
          autofocus: autoFocus,
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 12),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          textInputAction: TextInputAction.search, // changes enter to "search"
          onSubmitted: (_) => onSubmitted?.call(), // 👈 triggers callback
        ),
      ],
    );
  }
}
