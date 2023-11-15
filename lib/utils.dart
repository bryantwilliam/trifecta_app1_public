import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    lineLength: 80,
  ),
  output: _ConsoleOutput(),
);

class _ConsoleOutput extends LogOutput {
  // A fix to make logger show color on iOS.
  @override
  void output(OutputEvent event) {
    if (kReleaseMode || !Platform.isIOS) {
      event.lines.forEach(debugPrint);
    } else {
      event.lines.forEach(log);
    }
  }
}
