import 'package:flutter/material.dart';

class CenteredButton extends StatelessWidget {
  const CenteredButton({super.key, required this.onPress, required this.text});
  final dynamic onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: onPress,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    ));
  }
}
