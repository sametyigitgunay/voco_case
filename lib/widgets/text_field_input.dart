import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.hintText,
    this.isPass = false,
    required this.textEditingController,
    required this.textInputType,
  });
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.onPrimary,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
    );
  }
}
