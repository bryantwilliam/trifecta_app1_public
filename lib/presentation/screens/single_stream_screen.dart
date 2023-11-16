import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';
import 'package:trifecta_app1/data/providers/user_metric_future_provider.dart';
import 'package:trifecta_app1/presentation/widgets/async_user_metrics_widget.dart';
import 'package:trifecta_app1/presentation/widgets/atomic_containers/acc_stream_rvariable_container.dart';
import 'package:trifecta_app1/presentation/widgets/card_count_widget.dart';
import 'package:trifecta_app1/presentation/widgets/screen_description_widget.dart';

class SingleStreamScreen extends ConsumerWidget {
  const SingleStreamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;

    return AsyncUserMetricsWidget(
      asyncUserMetric:
          ref.watch(userMetricFutureProvider(AtomicConfiguration.containerId1)),
      onMetric: (metrics) {
        return ColoredBox(
          color: Theme.of(context).colorScheme.inversePrimary,
          child: Column(
            children: [
              const ScreenDescriptionWidget(
                'One big stream container.',
                color: Colors.black,
              ),
              Expanded(
                child: Crab(
                  tag: 'stream-1',
                  child: ACCStreamRVariableContainer(
                    runtimeVariablesEnabled: false,
                    width: screenSize.width,
                    containerId: AtomicConfiguration.containerId1,
                  ),
                ),
              ),
              Crab(
                tag: 'card-description',
                child: CardCountWidget(
                  totalCards: metrics.totalCards,
                  unseenCards: metrics.unseenCards,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
