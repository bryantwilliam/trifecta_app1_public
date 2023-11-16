import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:trifecta_app1/presentation/screens/assorted_stream_screen.dart';
import 'package:trifecta_app1/presentation/screens/double_stream_screen.dart';
import 'package:trifecta_app1/presentation/screens/single_stream_screen.dart';

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
          controller: _coastController,
          beaches: _screens,
          observers: [CrabController()],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _screenIndex,
        items: [
          SalomonBottomBarItem(
            icon: Icon(
              Icons.add_to_home_screen_rounded,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            activeIcon: Icon(
              Icons.add_to_home_screen_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('Single'),
            selectedColor: Theme.of(context).primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.looks_two_rounded,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            activeIcon: Icon(
              Icons.looks_two_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('Double'),
            selectedColor: Theme.of(context).primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.account_tree_rounded,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            activeIcon: Icon(
              Icons.account_tree_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('Assorted'),
            selectedColor: Theme.of(context).primaryColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            _screenIndex = index;
          });
          if (index == 2) {
            _coastController.animateTo(
              beach: _screenIndex,
              duration: const Duration(microseconds: 1),
              curve: Curves.linear,
            );
          } else {
            _coastController.animateTo(
              beach: _screenIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
            );
          }
        },
      ),
    );
  }
}
