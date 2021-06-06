import 'package:flutter/material.dart';
import 'package:linwood_launcher_app/app/entry.dart';

class AppTile extends StatelessWidget {
  final AppEntry entry;

  const AppTile(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {},
        child: Container(
            height: 150,
            width: 150,
            padding: EdgeInsets.all(16.0),
            child: Column(children: [Expanded(child: FlutterLogo(size: 64)), Text(entry.name)])),
      ),
    );
  }
}
