import 'package:flutter/material.dart';

Widget buildAppBar() {
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
            // TODO
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            // TODO
          },
        ),
      ]);
}
