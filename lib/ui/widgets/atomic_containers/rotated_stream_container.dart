import 'package:flutter/material.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';
import 'package:trifecta_app1/ui/widgets/atomic_containers/stream_container.dart';

class RotatedStreamContainer extends StatelessWidget {
  const RotatedStreamContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return RotatedBox(
      quarterTurns: 1,
      child: StreamContainer(
        // Since it's rotated, width becomes height and height becomes width.
        width: screenSize.height * 0.295,
        height: screenSize.width,
        containerId: AtomicConfiguration.containerId4,
        header: 'Horizontal list',
      ),
    );
  }
}
