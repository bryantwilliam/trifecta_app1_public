import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';
import 'package:trifecta_app1/data/providers/user_metric_future_provider.dart';
import 'package:trifecta_app1/ui/widgets/async_user_metrics_widget.dart';
import 'package:trifecta_app1/ui/widgets/atomic_containers/acc_stream_rvariable_container.dart';
import 'package:trifecta_app1/ui/widgets/card_count_widget.dart';
import 'package:trifecta_app1/ui/widgets/screen_description_widget.dart';

class DoubleStreamScreen extends ConsumerStatefulWidget {
  const DoubleStreamScreen({super.key});

  @override
  ConsumerState<DoubleStreamScreen> createState() => _DoubleStreamScreenState();
}

class _DoubleStreamScreenState extends ConsumerState<DoubleStreamScreen>
    with AutomaticKeepAliveClientMixin {
  // Unfortunately wantKeepAlive won't work with Hero or Crab widgets in the
  // state because the widget needs to rebuild while it animates.
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenSize = MediaQuery.of(context).size;

    return AsyncUserMetricsWidget(
      asyncUserMetric:
          ref.watch(userMetricFutureProvider(AtomicConfiguration.containerId1)),
      onMetric: (metrics) {
        return ColoredBox(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Expanded(
                child: Crab(
                  tag: 'stream-1',
                  child: ACCStreamRVariableContainer(
                    runtimeVariablesEnabled: false,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.008),
                child: const ScreenDescriptionWidget(
                  "Two identical stream containers, except one has the sealName runtime variable set to 'Bob', and the other doesn't. The cardListTitle was also changed.",
                  color: Colors.white,
                ),
              ),
              const Expanded(
                child: ACCStreamRVariableContainer(
                  runtimeVariablesEnabled: true,
                ),
              ),
              Crab(
                tag: 'card-description',
                child: CardCountWidget(
                  totalCards: metrics.totalCards,
                  unseenCards: metrics.unseenCards,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
