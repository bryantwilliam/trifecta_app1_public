import 'package:atomic_sdk_flutter/atomic_single_card_view.dart';
import 'package:atomic_sdk_flutter/atomic_stream_container.dart';
import 'package:flutter/material.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';
import 'package:trifecta_app1/presentation/widgets/card_reply_dialog.dart';

class AssortedStreamScreen extends StatefulWidget {
  const AssortedStreamScreen({super.key});

  @override
  State<AssortedStreamScreen> createState() => _AssortedStreamScreenState();
}

class _AssortedStreamScreenState extends State<AssortedStreamScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _useImageCard = false;

  Future<void> _showCardDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return CardReplyDialog(
          useImageCard: _useImageCard,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenSize = MediaQuery.of(context).size;

    // SingleChildScrollView is used to allow room for the datepicker to pop up.
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Use a container with image cards?'),
              Checkbox(
                value: _useImageCard,
                onChanged: (value) {
                  setState(() {
                    _useImageCard = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () => _showCardDialog(context),
                child: const Text('Send'),
              ),
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.32,
            child: AACSingleCardView(
              containerId: AtomicConfiguration.containerId2,
              configuration: AtomicConfiguration.getSingleCardConfiguration(),
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: SizedBox(
              // Since it's rotated, width becomes height and height becomes width.
              width: screenSize.height * 0.35,
              height: screenSize.width,
              child: AACStreamContainer(
                containerId: AtomicConfiguration.containerId4,
                configuration: AtomicConfiguration.getSingleCardConfiguration(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
