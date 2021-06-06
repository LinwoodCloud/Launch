import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

typedef void SystemCallback();

abstract class AppEntry {
  final String name;
  final String description;
  void onTap();
  Widget? buildWidget(BuildContext context);

  AppEntry(this.name, {this.description = ""});
}

class WebEntry extends AppEntry {
  final String url;
  WebEntry(String name, {String description = "", required this.url})
      : super(name, description: description);

  @override
  Widget? buildWidget(BuildContext context) {
    return Icon(PhosphorIcons.globeLight, size: 42);
  }

  @override
  void onTap() {
    print(url);
  }
}

class CommandEntry extends AppEntry {
  final String command;
  CommandEntry(String name, {String description = "", required this.command})
      : super(name, description: description);
  @override
  void onTap() {
    print(command);
  }

  @override
  Widget? buildWidget(BuildContext context) => Icon(PhosphorIcons.terminalLight, size: 42);
}

class SystemEntry extends AppEntry {
  final SystemCallback onClick;
  final Widget? widget;
  SystemEntry(String name, {String description = "", required this.onClick, this.widget})
      : super(name, description: description);

  @override
  Widget? buildWidget(BuildContext context) => widget;

  @override
  void onTap() => onClick();
}
