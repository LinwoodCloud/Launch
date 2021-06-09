import 'package:flutter/material.dart';

import 'layout.dart';

@immutable
abstract class Panel {
  Panel();
  Panel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();

  Widget buildWidget(PanelLayout panelLayout, BuildContext context);
}
