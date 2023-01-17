import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:linwood_launcher_app/app/entry.dart';
import 'package:linwood_launcher_app/app/list.dart';
import 'package:linwood_launcher_app/panels/app_list.dart';
import 'package:linwood_launcher_app/panels/layout.dart';
import 'package:linwood_launcher_app/panels/search_bar.dart';
import 'package:linwood_launcher_app/panels/service.dart';
import 'package:linwood_launcher_app/settings/personalization.dart';
import 'package:linwood_launcher_app/settings/search_engines.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'panels/empty.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PanelService service;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<PanelService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<PanelLayout>(
        stream: service.panelChanged,
        initialData: service.panelLayout,
        builder: (context, snapshot) {
          return ListView(children: [
            ...snapshot.data!.panels.toList().asMap().entries.map((entry) =>
                Builder(
                    builder: (context) => entry.value
                        .buildWidget(service.panelLayout, entry.key, context))),
            StreamBuilder<bool>(
                stream: service.editChanged,
                initialData: service.editing,
                builder: (context, snapshot) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (service.editing)
                            OutlinedButton.icon(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title:
                                                const Text('Choose an entry'),
                                            actions: [
                                              TextButton.icon(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  icon: const Icon(
                                                      PhosphorIcons.xLight),
                                                  label: const Text('CLOSE'))
                                            ],
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                      title: const Text(
                                                          'Search bar'),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() => service
                                                            .addPanel(SearchBarPanel(
                                                                searchEngine:
                                                                    SearchEngine
                                                                        .defaultEngines
                                                                        .first)));
                                                      }),
                                                  ListTile(
                                                      title: const Text(
                                                          'Empty panel'),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() =>
                                                            service.addPanel(
                                                                const EmptyPanel()));
                                                      }),
                                                  ListTile(
                                                      title: const Text(
                                                          'App list'),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() =>
                                                            service.addPanel(
                                                                const AppListPanel()));
                                                      }),
                                                  /* ExpansionTile(title: Text("App List"), children: [
                                    ListTile(onTap: () {}, title: Text("All apps")),
                                    ListTile(onTap: () {}, title: Text("Recently apps")),
                                    ListTile(onTap: () {}, title: Text("Featured apps")),
                                    ListTile(onTap: () {}, title: Text("Custom apps")),
                                  ]), */
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                label: const Text('Add'),
                                icon: const Icon(PhosphorIcons.plusLight),
                                style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20))),
                          IconButton(
                              icon: Icon(service.editing
                                  ? PhosphorIcons.xLight
                                  : PhosphorIcons.pencilLight),
                              onPressed: () =>
                                  service.editing = !service.editing),
                          !(snapshot.data!)
                              ? Container()
                              : AppList(
                                  title: 'System',
                                  description: 'Useful system apps',
                                  apps: [
                                      /* SystemEntry("General", widget: Icon(PhosphorIcons.wrenchLight), onClick: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("General settings"),
                    content: Center(child: Icon(PhosphorIcons.wrenchLight)),
                  ));
        }), */
                                      SystemEntry('Personalization',
                                          widget: const Icon(
                                              PhosphorIcons.fadersLight),
                                          onClick: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PersonalizationSettingsPage()))),
                                      /* SystemEntry("Updates",
            widget: Icon(PhosphorIcons.arrowCounterClockwiseLight), onClick: () {}), */
                                      SystemEntry('Code',
                                          widget: const Icon(
                                              PhosphorIcons.codeLight),
                                          onClick: () => launchUrl(Uri.https(
                                              'github.com',
                                              'LinwoodCloud/Launcher'))),
                                      SystemEntry('Search Engines',
                                          widget: const Icon(PhosphorIcons
                                              .magnifyingGlassLight),
                                          onClick: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SearchEnginesSettingsPage()))),
                                      /* SystemEntry("Apps",
                  widget: Icon(PhosphorIcons.appWindowLight, size: 42), onClick: () {}),
              SystemEntry("Updates",
                  widget: Icon(PhosphorIcons.arrowCounterClockwiseLight, size: 42), onClick: () {}),
              SystemEntry("Wifi",
                  widget: Icon(PhosphorIcons.wifiHighLight, size: 42), onClick: () {}),
              SystemEntry("Bluetooth",
                  widget: Icon(PhosphorIcons.bluetoothLight, size: 42), onClick: () {}), */
                                      SystemEntry('Information',
                                          widget: const Icon(
                                              PhosphorIcons.infoLight,
                                              size: 42),
                                          onClick: () =>
                                              showAboutDialog(context: context))
                                    ])
                        ]))
          ]);
        },
      ),
    );
  }
}
