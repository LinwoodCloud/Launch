import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

typedef SystemCallback = void Function();

abstract class AppEntry {
  final String name;
  final String description;
  void onTap();
  Widget? buildWidget(BuildContext context);

  AppEntry(this.name, {this.description = ""});

  Map<String, dynamic> toJson();
}

class WebEntry extends AppEntry {
  final String url;
  WebEntry(String name, {String description = "", required this.url})
      : super(name, description: description);

  @override
  Widget? buildWidget(BuildContext context) {
    return Icon(PhosphorIcons.globeLight);
  }

  @override
  void onTap() => launch(url);

  @override
  Map<String, dynamic> toJson() =>
      {"type": "web-entry", "name": name, "description": description, "url": url};
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
  Widget? buildWidget(BuildContext context) => Icon(PhosphorIcons.terminalLight);

  @override
  Map<String, dynamic> toJson() =>
      {"type": "system-entry", "name": name, "description": description, "command": command};
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

  @override
  Map<String, dynamic> toJson() =>
      {"type": "system-entry", "name": name, "description": description};
}
