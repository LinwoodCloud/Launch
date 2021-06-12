import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:linwood_launcher_app/app/entry.dart';
import 'package:linwood_launcher_app/app/tile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'layout.dart';
import 'panel.dart';
import 'service.dart';

class AppListPanel extends Panel {
  final List<AppEntry> apps;

  AppListPanel({this.apps = const []});
  AppListPanel.fromJson(Map<String, dynamic> json)
      : apps = ((json['apps'] ?? []) as List<dynamic>).map((e) {
          switch (e['type']) {
            case "url-entry":
            default:
              return UrlEntry.fromJson(e as Map<String, dynamic>);
          }
        }).toList();
  @override
  Widget buildWidget(PanelLayout panelLayout, int index, BuildContext context) =>
      AppListPanelWidget(index: index, panelLayout: panelLayout);

  AppListPanel copyWith({List<AppEntry>? apps}) => AppListPanel(apps: apps ?? this.apps);

  @override
  Map<String, dynamic> toJson() =>
      {"type": "app-list", "apps": apps.map((e) => e.toJson()).toList()};
}

class AppListPanelWidget extends StatefulWidget {
  final int index;
  final PanelLayout panelLayout;
  const AppListPanelWidget({Key? key, required this.index, required this.panelLayout})
      : super(key: key);

  @override
  _AppListPanelWidgetState createState() => _AppListPanelWidgetState();
}

class _AppListPanelWidgetState extends State<AppListPanelWidget> {
  late PanelService service;
  late AppListPanel panel;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<PanelService>();
    panel = service.panelLayout.panels[widget.index] as AppListPanel;
  }

  @override
  void didUpdateWidget(AppListPanelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      panel = service.panelLayout.panels[widget.index] as AppListPanel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(children: [
                Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: panel.apps
                                .asMap()
                                .entries
                                .map((e) => AppTile(e.value, onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text("Configure app entry"),
                                                actions: [
                                                  TextButton.icon(
                                                      onPressed: () => Navigator.of(context).pop(),
                                                      icon: Icon(PhosphorIcons.xLight),
                                                      label: Text("CLOSE"))
                                                ],
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                          title: Text("Set name"),
                                                          onTap: () {
                                                            Navigator.of(context).pop();
                                                            showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  var _controller =
                                                                      TextEditingController();
                                                                  return AlertDialog(
                                                                      title: Text("Set name"),
                                                                      content: TextField(
                                                                          controller: _controller,
                                                                          decoration: InputDecoration(
                                                                              labelText: "Name",
                                                                              hintText:
                                                                                  "Website name")),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.of(
                                                                                        context)
                                                                                    .pop(),
                                                                            child: Text("CANCEL")),
                                                                        TextButton(
                                                                            onPressed: () {
                                                                              Navigator.of(context)
                                                                                  .pop();
                                                                              setState(() {
                                                                                panel = panel.copyWith(
                                                                                    apps: List<
                                                                                            AppEntry>.from(
                                                                                        panel.apps)
                                                                                      ..[e.key] = (e
                                                                                                  .value
                                                                                              as UrlEntry)
                                                                                          .copyWith(
                                                                                              name:
                                                                                                  _controller.text));
                                                                                service.updatePanel(
                                                                                    widget.index,
                                                                                    panel);
                                                                              });
                                                                            },
                                                                            child: Text("OK"))
                                                                      ]);
                                                                });
                                                          }),
                                                      ListTile(
                                                          title: Text("Set url"),
                                                          onTap: () {
                                                            Navigator.of(context).pop();
                                                            showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  var _controller =
                                                                      TextEditingController();
                                                                  return AlertDialog(
                                                                      title: Text("Set url"),
                                                                      content: TextField(
                                                                          controller: _controller,
                                                                          decoration: InputDecoration(
                                                                              labelText: "URL",
                                                                              hintText:
                                                                                  "https://example.com")),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.of(
                                                                                        context)
                                                                                    .pop(),
                                                                            child: Text("CANCEL")),
                                                                        TextButton(
                                                                            onPressed: () {
                                                                              Navigator.of(context)
                                                                                  .pop();
                                                                              setState(() {
                                                                                panel = panel.copyWith(
                                                                                    apps: List<
                                                                                            AppEntry>.from(
                                                                                        panel.apps)
                                                                                      ..[e.key] = (e
                                                                                                  .value
                                                                                              as UrlEntry)
                                                                                          .copyWith(
                                                                                              url: _controller
                                                                                                  .text));
                                                                                service.updatePanel(
                                                                                    widget.index,
                                                                                    panel);
                                                                              });
                                                                            },
                                                                            child: Text("OK"))
                                                                      ]);
                                                                });
                                                          }),
                                                      ListTile(
                                                          title: Text("Remove"),
                                                          onTap: () {
                                                            Navigator.of(context).pop();
                                                            setState(() {
                                                              panel = panel.copyWith(
                                                                  apps: List<AppEntry>.from(
                                                                      panel.apps)
                                                                    ..removeAt(e.key));
                                                              service.updatePanel(
                                                                  widget.index, panel);
                                                            });
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    }))
                                .toList()))),
                PopupMenuButton<VoidCallback>(
                    onSelected: (value) => value(),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Text("Add"),
                              value: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    var _controller = TextEditingController();
                                    return AlertDialog(
                                        title: Text("Set url"),
                                        content: TextField(
                                            controller: _controller,
                                            keyboardType: TextInputType.url,
                                            decoration: InputDecoration(
                                                labelText: "URL", hintText: "https://example.com")),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.of(context).pop(),
                                              child: Text("CANCEL")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  panel = panel.copyWith(
                                                      apps: List<AppEntry>.from(panel.apps)
                                                        ..add(UrlEntry(_controller.text,
                                                            url: _controller.text)));
                                                  service.updatePanel(widget.index, panel);
                                                });
                                              },
                                              child: Text("OK"))
                                        ]);
                                  })),
                          PopupMenuDivider(),
                          ...PanelOptions.values
                              .map((e) => PopupMenuItem(
                                  child: Text(e.name), value: () => e.onTap(widget.index)))
                              .toList()
                        ])
              ]))),
    );
  }
}
