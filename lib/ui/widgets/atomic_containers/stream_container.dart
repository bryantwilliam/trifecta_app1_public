import 'package:atomic_sdk_flutter/atomic_stream_container.dart';
import 'package:flutter/material.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';
import 'package:trifecta_app1/ui/widgets/atomic_containers/atomic_container.dart';

class StreamContainer extends AtomicContainer {
  const StreamContainer({
    required super.containerId,
    this.header,
    this.footer,
    super.height,
    super.width,
    super.key,
  });
  final String? header;
  final String? footer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: AACStreamContainer(
        containerId: containerId,
        configuration: AtomicConfiguration.getStreamContainerConfiguration(
          header: header,
          footer: footer,
        ),
      ),
    );
  }
}
