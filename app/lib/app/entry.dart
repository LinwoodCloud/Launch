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
  AppEntry.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        description = json['description'] as String;

  Map<String, dynamic> toJson() => {"name": name, "description": description};
}

class UrlEntry extends AppEntry {
  final String url;
  UrlEntry(String name, {String description = "", required this.url})
      : super(name, description: description);
  UrlEntry.fromJson(Map<String, dynamic> json)
      : url = json['url'] as String,
        super.fromJson(json);

  @override
  Widget? buildWidget(BuildContext context) {
    return Icon(PhosphorIcons.globeLight);
  }

  @override
  void onTap() => launch(url);

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({"type": "url-entry", "url": url});

  UrlEntry copyWith({String? name, String? description, String? url}) => UrlEntry(name ?? this.name,
      url: url ?? this.url, description: description ?? this.description);
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
  Map<String, dynamic> toJson() => {"type": "command-entry", "command": command};
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
  Map<String, dynamic> toJson() => super.toJson()..addAll({"type": "system-entry"});
}
