import 'package:flutter/material.dart';
import 'package:linwood_launcher_app/app/entry.dart';
import 'package:linwood_launcher_app/app/list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      AppList(title: "Opened apps"),
      AppList(title: "All apps", apps: [
        WebEntry("Search", url: "example.com"),
        WebEntry("Search", url: "example.com"),
        WebEntry("Search", url: "example.com"),
        WebEntry("Search", url: "example.com"),
        WebEntry("Search", url: "example.com")
      ]),
      OutlinedButton.icon(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Choose an entry"),
                      actions: [
                        TextButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.close_outlined),
                            label: Text("CLOSE"))
                      ],
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(onTap: () {}, title: Text("All apps")),
                            ListTile(onTap: () {}, title: Text("Recently apps")),
                            ListTile(onTap: () {}, title: Text("Featured apps")),
                            ListTile(onTap: () {}, title: Text("Custom apps")),
                          ],
                        ),
                      ),
                    ));
          },
          label: Text("Add"),
          icon: Icon(Icons.add_outlined),
          style:
              OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20)))
    ]));
  }
}
