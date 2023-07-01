import 'package:flutter/material.dart';

class LabelChip extends StatelessWidget {
  final String label;
  final Color? color;

  const LabelChip({super.key, required this.label, this.color});
  // const LabelChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
        // backgroundColor: const Color.fromARGB(255, 225, 228, 243),
        backgroundColor: color ?? const Color.fromARGB(255, 225, 228, 243),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        label: Text(label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                )
            // color: color ?? Theme.of(context).primaryColor
            // color: color ?? const Color.fromRGBO(54, 73, 174, 1)),
            ));
  }
}
