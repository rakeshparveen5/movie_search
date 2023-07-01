import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  final String text;
  const TextHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
