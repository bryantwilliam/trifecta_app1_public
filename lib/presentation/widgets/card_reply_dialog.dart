import 'package:atomic_sdk_flutter/atomic_single_card_view.dart';
import 'package:flutter/material.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';

class CardReplyDialog extends StatelessWidget {
  const CardReplyDialog({required this.useImageCard, super.key});
  final bool useImageCard;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Capy Bara sent you a reply back instantly!'),
      content: AACSingleCardView(
        containerId: useImageCard
            ? AtomicConfiguration.containerId1
            : AtomicConfiguration.containerId3,
        configuration: AtomicConfiguration.getSingleCardConfiguration(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Okay'),
        ),
      ],
    );
  }
}
