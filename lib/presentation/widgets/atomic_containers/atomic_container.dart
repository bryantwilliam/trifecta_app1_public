import 'package:flutter/material.dart';

abstract class AtomicContainer extends StatelessWidget {
  const AtomicContainer({
    required this.containerId,
    this.height,
    this.width,
    super.key,
  });
  final double? height;
  final double? width;
  final String containerId;
}
