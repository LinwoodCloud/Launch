import 'package:flutter/material.dart';
import 'package:linwood_launcher_app/panels/panel.dart';

import 'layout.dart';

class EmptyPanel extends Panel {
  final int height;

  EmptyPanel({this.height = 50});
  EmptyPanel.fromJson(Map<String, dynamic> json) : height = json['height'] as int;
  @override
  Widget buildWidget(PanelLayout panelLayout, BuildContext context) {
    // TODO: implement buildWidget
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() => {"height": height, "type": "empty"};
}
