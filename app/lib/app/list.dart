import 'package:flutter/material.dart';

import 'entry.dart';
import 'tile.dart';

class AppList extends StatelessWidget {
  final List<AppEntry> apps;
  final Widget? trailing;
  final Widget? leading;
  final String title;
  final ScrollController _scrollController = ScrollController();
  final String description;

  AppList(
      {Key? key,
      this.apps = const [],
      this.title = "",
      this.description = "",
      this.trailing,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (leading != null) leading!,
                  Expanded(
                      child: Column(
                    children: [
                      Text(title, style: Theme.of(context).textTheme.headline5),
                      Text(description)
                    ],
                  )),
                  if (trailing != null) trailing!
                ],
              ),
            ),
            Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(children: apps.map((e) => AppTile(e)).toList())),
            )
          ]),
    ));
  }
}
