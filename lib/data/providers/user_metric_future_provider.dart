import 'dart:async';

import 'package:atomic_sdk_flutter/atomic_session.dart';
import 'package:atomic_sdk_flutter/atomic_stream_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trifecta_app1/data/atomic_configuration.dart';
import 'package:trifecta_app1/utils.dart';

// FutureProvider will catch and handle errors for us using the AsyncValue.
final userMetricFutureProvider =
    FutureProvider.family<AACUserMetrics, String>((ref, containerId) async {
  // FutureProvider makes this only runs once even if ref.watch is called multiple times.
  await _login();
  return AACSession.userMetrics(containerId);
});

Future<void> _login() async {
  // Atomic SDK redirects errors/exceptions to the FlutterError.onError pipeline.
  FlutterError.onError = logger.e;

  final secretConfig = await AtomicConfiguration.secretConfig;

  await AACSession.enableDebugMode(3);
  await AACSession.setApiBaseUrl(secretConfig.apiUrl);
  await AACSession.initialise(
    AtomicConfiguration.environmentId,
    secretConfig.apiKey,
  );
  await AACSession.setSessionDelegate(_AACSessionDelegate());

  //await Future.delayed(const Duration(seconds: 5)); // for testing loading ui.
  //throw Exception("test error"); // for testing error ui.
  logger.t('login success');
}

class _AACSessionDelegate extends AACSessionDelegate {
  @override
  Future<String> authToken() {
    return AtomicConfiguration.token;
  }
}
