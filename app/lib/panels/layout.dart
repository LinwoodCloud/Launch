import 'package:flutter/cupertino.dart';
import 'package:linwood_launcher_app/panels/empty.dart';
import 'package:linwood_launcher_app/panels/panel.dart';
import 'package:linwood_launcher_app/panels/search_bar.dart';

@immutable
class PanelLayout {
  final List<Panel> panels;
  PanelLayout({List<Panel> panels = const []}) : panels = List<Panel>.unmodifiable(panels);
  PanelLayout.fromJson(Map<String, dynamic> json)
      : panels = List<Map<String, dynamic>>.from((json['panels'] as List<dynamic>?) ?? []).map((e) {
          switch (e['type']) {
            case "search-bar":
              return SearchBarPanel.fromJson(e);
            case "empty":
            default:
              return EmptyPanel.fromJson(e);
          }
        }).toList();

  Map<String, dynamic> toJson() => {"panels": panels};

  PanelLayout copyWith({List<Panel>? panels}) => PanelLayout(panels: panels ?? this.panels);
}
