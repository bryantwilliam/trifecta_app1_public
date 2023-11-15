import 'package:atomic_sdk_flutter/atomic_card_runtime_variable.dart';
import 'package:atomic_sdk_flutter/atomic_stream_container.dart';
import 'package:flutter/material.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';

class ACCStreamContainerWidget extends StatelessWidget {
  const ACCStreamContainerWidget({
    required this.width,
    required this.runtimeVariablesEnabled,
    required this.containerId,
    super.key,
  });
  final double width;
  final bool runtimeVariablesEnabled;
  final String containerId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: AACStreamContainer(
        runtimeVariableDelegate:
            runtimeVariablesEnabled ? _CardRuntimeVariableDelegate() : null,
        configuration: AtomicConfiguration.getConfiguration(
          runtimeVariablesEnabled
              ? 'Runtime variables: on'
              : 'Runtime variables: off',
        ),
        containerId: AtomicConfiguration.containerId1,
      ),
    );
  }
}

class _CardRuntimeVariableDelegate extends AACRuntimeVariableDelegate {
  @override
  Future<List<AACCardInstance>> requestRuntimeVariables(
    List<AACCardInstance> cardInstances,
  ) {
    for (final card in cardInstances) {
      // Resolve a runtime variable 'sealName' to 'Bob' on all cards.
      // You can also inspect `lifecycleId` and `cardInstanceId` to determine what type of card this is.
      card.resolveRuntimeVariable('sealName', 'Bob');
    }
    return Future.value(cardInstances);
  }
}
