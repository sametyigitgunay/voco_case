import 'package:flutter/material.dart';

class LoginTextButton extends StatelessWidget {
  const LoginTextButton({super.key, required this.onPress, required this.text});
  final dynamic onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
          onPressed: onPress,
          child: Text(
    text,
    style: Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: Theme.of(context).colorScheme.inversePrimary),
          ),
        );
  }
}
