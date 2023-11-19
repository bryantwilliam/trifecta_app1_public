import 'package:atomic_sdk_flutter/atomic_single_card_view.dart';
import 'package:flutter/material.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';
import 'package:trifecta_app1/ui/widgets/atomic_containers/atomic_container.dart';

class SingleCardView extends AtomicContainer {
  const SingleCardView({
    required super.containerId,
    super.height,
    super.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: AACSingleCardView(
        containerId: containerId,
        configuration: AtomicConfiguration.getSingleCardConfiguration(),
      ),
    );
  }
}
