import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';
import 'package:trifecta_app1/data/providers/user_metric_future_provider.dart';
import 'package:trifecta_app1/ui/widgets/atomic_containers/rotated_stream_container.dart';
import 'package:trifecta_app1/ui/widgets/atomic_containers/single_card_view.dart';
import 'package:trifecta_app1/ui/widgets/dialogs/card_dialog.dart';

class AssortedStreamScreen extends ConsumerStatefulWidget {
  const AssortedStreamScreen({super.key});

  @override
  ConsumerState<AssortedStreamScreen> createState() =>
      _AssortedStreamScreenState();
}

class _AssortedStreamScreenState extends ConsumerState<AssortedStreamScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  var _isSingle = true;
  var _cardViewCount = 2;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenSize = MediaQuery.of(context).size;

    final cardCount = ref
            .watch(userMetricFutureProvider(AtomicConfiguration.containerId2))
            .whenOrNull(
          data: (metrics) {
            return metrics.totalCards;
          },
        ) ??
        0;

    final colorScheme = Theme.of(context).colorScheme;

    // SingleChildScrollView is used to allow room for the datepicker to pop up.
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Use a Single Card View for notifications?',
                style: TextStyle(color: colorScheme.primary),
              ),
              Checkbox(
                activeColor: colorScheme.primary,
                value: _isSingle,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _isSingle = value;
                    }
                  });
                },
              ),
              SizedBox(
                height: screenSize.height * 0.05,
                width: screenSize.width * 0.1,
                child: Badge(
                  // Badge has a offset by default that is too far away
                  offset: Offset.zero,
                  backgroundColor: colorScheme.inversePrimary,
                  textColor: Colors.black,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  isLabelVisible: cardCount > 0,
                  label: Text(cardCount.toString()),
                  child: IconButton(
                    // IconButton has weird left and top padding by default
                    padding: EdgeInsets.zero,
                    iconSize: screenSize.width * 0.1,
                    onPressed: () => _showCardDialog(context),
                    icon: Icon(
                      Icons.notifications,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _cardViewCount > 2
                    ? () => setState(() => _cardViewCount--)
                    : null,
              ),
              Text('$_cardViewCount shrunken single card views'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => _cardViewCount++),
              ),
            ],
          ),
          FittedBox(
            child: Row(
              children: List<SingleCardView>.filled(
                _cardViewCount,
                SingleCardView(
                  height: screenSize.height * 0.32,
                  width: screenSize.width,
                  containerId: AtomicConfiguration.containerId4,
                ),
              ),
            ),
          ),
          const Text('One rotated stream container'),
          const RotatedStreamContainer(),
          const Text('Two shrunken, rotated stream containers'),
          const FittedBox(
            child: Row(
              children: [
                RotatedStreamContainer(),
                RotatedStreamContainer(),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Text('hi :)'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCardDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (_) {
        if (_isSingle) {
          return const CardDialog(
            containerId: AtomicConfiguration.containerId2,
            isSingle: true,
          );
        } else {
          return const CardDialog(
            containerId: AtomicConfiguration.containerId2,
            isSingle: false,
          );
        }
      },
    );
  }
}
