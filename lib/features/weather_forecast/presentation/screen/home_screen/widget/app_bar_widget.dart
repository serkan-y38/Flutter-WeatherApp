import 'package:flutter/material.dart';

Widget buildAppBar({required Function() onSettingsClicked, required Function() onSearchClicked}) {
  return SliverAppBar(
      floating: true,
      snap: true,
      title: const Text(""),
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Settings',
          onPressed: () {
            onSettingsClicked();
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            onSearchClicked();
          },
        ),
      ]);
}
