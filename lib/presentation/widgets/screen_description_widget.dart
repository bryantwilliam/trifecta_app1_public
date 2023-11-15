import 'package:flutter/material.dart';

class ScreenDescriptionWidget extends StatelessWidget {
  const ScreenDescriptionWidget(
    this.description, {
    required this.color,
    super.key,
  });
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
        textAlign: TextAlign.center,
      ),
    );
  }
}
