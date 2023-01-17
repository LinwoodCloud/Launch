import 'package:flutter/material.dart';
import 'package:linwood_launcher_app/app/entry.dart';

class AppTile extends StatelessWidget {
  final AppEntry entry;
  final GestureLongPressCallback? onLongPress;

  const AppTile(this.entry, {Key? key, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: entry.onTap,
        onLongPress: onLongPress,
        child: Container(
            height: 150,
            width: 150,
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Expanded(
                  child: IconTheme(
                      data: IconThemeData(
                          color: Theme.of(context).primaryColor, size: 42),
                      child: Builder(
                          builder: (context) =>
                              entry.buildWidget(context) ?? Container()))),
              Text(entry.name)
            ])),
      ),
    );
  }
}
