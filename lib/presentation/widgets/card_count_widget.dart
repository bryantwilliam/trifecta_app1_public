import 'package:flutter/material.dart';

class CardCountWidget extends StatelessWidget {
  const CardCountWidget({
    required this.totalCards,
    required this.unseenCards,
    required this.color,
    super.key,
  });
  final int totalCards;
  final int unseenCards;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        '$totalCards total cards! And $unseenCards unseen cards!',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: color,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
