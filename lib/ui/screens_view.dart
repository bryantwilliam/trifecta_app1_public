import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:trifecta_app1/ui/bottom_bar_item.dart';
import 'package:trifecta_app1/ui/screens/assorted_stream_screen.dart';
import 'package:trifecta_app1/ui/screens/double_stream_screen.dart';
import 'package:trifecta_app1/ui/screens/single_stream_screen.dart';

class ScreensView extends StatefulWidget {
  const ScreensView({super.key});

  @override
  State<ScreensView> createState() => _ScreensViewState();
}

class _ScreensViewState extends State<ScreensView> {
  int _screenIndex = 0;

  final _screens = [
    Beach(builder: (context) => const SingleStreamScreen()),
    Beach(builder: (context) => const DoubleStreamScreen()),
    Beach(builder: (context) => const AssortedStreamScreen()),
  ];
  final _coastController = CoastController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trifecta Demo App 1'),
      ),
      body: SafeArea(
        child: Coast(
          physics: const NeverScrollableScrollPhysics(),
          controller: _coastController,
          beaches: _screens,
          observers: [CrabController()],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _screenIndex,
        items: [
          BottomBarItem(context, Icons.add_to_home_screen_rounded, 'Single'),
          BottomBarItem(context, Icons.looks_two_rounded, 'Double'),
          BottomBarItem(context, Icons.account_tree_rounded, 'Assorted'),
        ],
        onTap: (index) {
          if (index == 2 || _screenIndex == 2) {
            // Doesn't animate if coming to or from the 3rd page.
            _coastController.animateTo(
              beach: index,
              duration: const Duration(microseconds: 1),
              curve: Curves.linear,
            );
          } else {
            _coastController.animateTo(
              beach: index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
            );
          }
          setState(() {
            _screenIndex = index;
          });
        },
      ),
    );
  }
}
