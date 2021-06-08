import 'package:flutter/material.dart';
import 'package:linwood_launcher_app/app/entry.dart';
import 'package:linwood_launcher_app/app/list.dart';
import 'package:linwood_launcher_app/panels/search_bar.dart';
import 'package:linwood_launcher_app/settings/personalization.dart';
import 'package:linwood_launcher_app/settings/search_engines.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
      SearchBarPanel(SearchEngine.defaultEngines[0]).buildWidget(context),
      AppList(title: "Opened apps"),
      AppList(title: "All apps", apps: [
        WebEntry("Search", url: "https://example.com"),
        WebEntry("Search", url: "https://example.com"),
        WebEntry("Search", url: "https://example.com"),
        WebEntry("Search", url: "https://example.com"),
        WebEntry("Search", url: "https://example.com")
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
                            icon: Icon(PhosphorIcons.xLight),
                            label: Text("CLOSE"))
                      ],
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(title: Text("Search bar")),
                            ExpansionTile(title: Text("App List"), children: [
                              ListTile(onTap: () {}, title: Text("All apps")),
                              ListTile(onTap: () {}, title: Text("Recently apps")),
                              ListTile(onTap: () {}, title: Text("Featured apps")),
                              ListTile(onTap: () {}, title: Text("Custom apps")),
                            ]),
                          ],
                        ),
                      ),
                    ));
          },
          label: Text("Add"),
          icon: Icon(PhosphorIcons.plusLight),
          style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20))),
      AppList(title: "System", description: "Useful system apps", apps: [
        /* SystemEntry("General", widget: Icon(PhosphorIcons.wrenchLight), onClick: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("General settings"),
                    content: Center(child: Icon(PhosphorIcons.wrenchLight)),
                  ));
        }), */
        SystemEntry("Personalization",
            widget: Icon(PhosphorIcons.fadersLight),
            onClick: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PersonalizationSettingsPage()))),
        /* SystemEntry("Updates",
            widget: Icon(PhosphorIcons.arrowCounterClockwiseLight), onClick: () {}), */
        SystemEntry("Code",
            widget: Icon(PhosphorIcons.codeLight),
            onClick: () => launch("https://github.com/LinwoodCloud/Launcher")),
        SystemEntry("Search Engines",
            widget: Icon(PhosphorIcons.magnifyingGlassLight),
            onClick: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SearchEnginesSettingsPage()))),
        SystemEntry("Apps", widget: Icon(PhosphorIcons.appWindowLight, size: 42), onClick: () {}),
        SystemEntry("Personalization",
            widget: Icon(PhosphorIcons.fadersLight, size: 42), onClick: () {}),
        SystemEntry("Updates",
            widget: Icon(PhosphorIcons.arrowCounterClockwiseLight, size: 42), onClick: () {}),
        SystemEntry("Wifi", widget: Icon(PhosphorIcons.wifiHighLight, size: 42), onClick: () {}),
        SystemEntry("Bluetooth",
            widget: Icon(PhosphorIcons.bluetoothLight, size: 42), onClick: () {}),
        SystemEntry("Information", widget: Icon(PhosphorIcons.infoLight, size: 42), onClick: () {})
      ])
    ]));
  }
}
