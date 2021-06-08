import 'package:flutter/material.dart';

abstract class Panel {
  Panel();
  Panel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();

  Widget buildWidget(BuildContext context);
}
