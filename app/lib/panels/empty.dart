import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:linwood_launcher_app/panels/panel.dart';

import 'layout.dart';
import 'service.dart';

class EmptyPanel extends Panel {
  final double height;

  const EmptyPanel({this.height = 50.0});
  EmptyPanel.fromJson(Map<String, dynamic> json)
      : height = json['height'] as double;
  @override
  Widget buildWidget(
          PanelLayout panelLayout, int index, BuildContext context) =>
      EmptyPanelWidget(index: index, panelLayout: panelLayout);

  @override
  Map<String, dynamic> toJson() => {'height': height, 'type': 'empty'};

  EmptyPanel copyWith({double? height}) =>
      EmptyPanel(height: height ?? this.height);
}

class EmptyPanelWidget extends StatefulWidget {
  final int index;
  final PanelLayout panelLayout;
  const EmptyPanelWidget(
      {Key? key, required this.index, required this.panelLayout})
      : super(key: key);

  @override
  _EmptyPanelWidgetState createState() => _EmptyPanelWidgetState();
}

class _EmptyPanelWidgetState extends State<EmptyPanelWidget> {
  late PanelService service;
  late EmptyPanel panel;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<PanelService>();
    panel = service.panelLayout.panels[widget.index] as EmptyPanel;
  }

  @override
  void didUpdateWidget(EmptyPanelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      panel = service.panelLayout.panels[widget.index] as EmptyPanel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Row(children: [
              Expanded(child: SizedBox(height: panel.height)),
              StreamBuilder<bool>(
                  stream: service.editChanged,
                  initialData: service.editing,
                  builder: (context, snapshot) => !(snapshot.data!)
                      ? Container()
                      : PopupMenuButton<VoidCallback>(
                          onSelected: (value) => value(),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: const Text('Height'),
                                    value: () => showDialog(
                                        context: context,
                                        builder: (context) {
                                          var controller =
                                              TextEditingController(
                                                  text:
                                                      panel.height.toString());
                                          return AlertDialog(
                                              title: const Text('Set height'),
                                              content: TextField(
                                                  controller: controller,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Height',
                                                          hintText: '50')),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child:
                                                        const Text('CANCEL')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        panel = panel.copyWith(
                                                            height:
                                                                double.tryParse(
                                                                    controller
                                                                        .text));
                                                        service.updatePanel(
                                                            widget.index,
                                                            panel);
                                                      });
                                                    },
                                                    child: const Text('OK'))
                                              ]);
                                        })),
                                const PopupMenuDivider(),
                                ...PanelOptions.values
                                    .map((e) => PopupMenuItem(
                                        child: Text(e.name),
                                        value: () => e.onTap(widget.index)))
                                    .toList()
                              ]))
            ])));
  }
}
