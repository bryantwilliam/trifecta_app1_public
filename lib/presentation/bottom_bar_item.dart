import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBarItem extends SalomonBottomBarItem {
  BottomBarItem(BuildContext context, IconData iconData, String title)
      : super(
          icon: Icon(
            iconData,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          activeIcon: Icon(
            iconData,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(title),
          selectedColor: Theme.of(context).primaryColor,
        );
}
