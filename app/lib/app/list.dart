import 'package:flutter/material.dart';

import 'entry.dart';
import 'tile.dart';

class AppList extends StatelessWidget {
  final List<AppEntry> apps;
  final String title;
  final String description;

  const AppList({Key? key, this.apps = const [], this.title = "", this.description = ""})
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
                  Expanded(
                      child: Column(
                    children: [
                      Text(title, style: Theme.of(context).textTheme.headline5),
                      Text(description)
                    ],
                  )),
                  IconButton(
                    icon: Icon(Icons.edit_outlined),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Scrollbar(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: apps.map((e) => AppTile(e)).toList())),
            )
          ]),
    ));
  }
}
