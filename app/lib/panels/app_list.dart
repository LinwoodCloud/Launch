import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:linwood_launcher_app/app/entry.dart';

import 'layout.dart';
import 'panel.dart';
import 'service.dart';

class AppListPanel extends Panel {
  final List<AppEntry> apps;

  AppListPanel({this.apps = const []});
  AppListPanel.fromJson(Map<String, dynamic> json) : apps = json['apps'] as List<AppEntry>;
  @override
  Widget buildWidget(PanelLayout panelLayout, int index, BuildContext context) =>
      AppListPanelWidget(index: index, panelLayout: panelLayout);

  @override
  Map<String, dynamic> toJson() => {"type": "app-list", "apps": apps.map((e) => e.toJson())};
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
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Row(children: [
              PopupMenuButton<VoidCallback>(
                  onSelected: (value) => value(),
                  itemBuilder: (context) => [
                        PopupMenuDivider(),
                        ...PanelOptions.values
                            .map((e) => PopupMenuItem(
                                child: Text(e.name), value: () => e.onTap(widget.index)))
                            .toList()
                      ])
            ])));
  }
}
