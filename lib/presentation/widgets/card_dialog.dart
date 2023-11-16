import 'package:atomic_sdk_flutter/atomic_single_card_view.dart';
import 'package:atomic_sdk_flutter/atomic_stream_container.dart';
import 'package:flutter/material.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';

class CardDialog extends StatelessWidget {
  const CardDialog({
    required this.containerId,
    required this.isSingle,
    super.key,
  });
  final String containerId;
  final bool isSingle;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(isSingle ? 'Single Card View' : 'Stream Container'),
      // AlertDialog has contentPadding by default
      contentPadding: EdgeInsets.only(top: screenSize.height * 0.01),
      actionsAlignment: MainAxisAlignment.center,
      // AlertDialog has actionsPadding by default
      actionsPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.symmetric(vertical: screenSize.height * 0.05),
      content: SizedBox(
        width: screenSize.width * 0.85,
        child: isSingle
            ? AACSingleCardView(
                containerId: containerId,
                configuration: AtomicConfiguration.getSingleCardConfiguration(),
              )
            : AACStreamContainer(
                containerId: containerId,
                configuration:
                    AtomicConfiguration.getStreamContainerConfiguration(
                  title: 'Seals',
                ),
              ),
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
