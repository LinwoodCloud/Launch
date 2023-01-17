import 'package:flutter/material.dart';

import 'layout.dart';

@immutable
abstract class Panel {
  const Panel();
  const Panel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();

  Widget buildWidget(PanelLayout panelLayout, int index, BuildContext context);
}
