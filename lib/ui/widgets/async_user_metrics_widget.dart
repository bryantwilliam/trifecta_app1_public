import 'package:atomic_sdk_flutter/atomic_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trifecta_app1/utils.dart';

class AsyncUserMetricsWidget extends StatelessWidget {
  const AsyncUserMetricsWidget({
    required this.asyncUserMetric,
    required this.onMetric,
    super.key,
  });
  final Widget Function(AACUserMetrics) onMetric;
  final AsyncValue<AACUserMetrics> asyncUserMetric;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return asyncUserMetric.when<Widget>(
      loading: () {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Logging in...'),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            const CircularProgressIndicator(),
          ],
        );
      },
      error: (Object error, StackTrace stackTrace) {
        logger.e(error.toString());
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Error logging in!',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Text(
              '$error',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        );
      },
      data: onMetric,
    );
  }
}
