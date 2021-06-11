import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:linwood_launcher_app/panels/empty.dart';
import 'package:linwood_launcher_app/panels/panel.dart';
import 'package:linwood_launcher_app/panels/search_bar.dart';
import 'package:linwood_launcher_app/panels/service.dart';

import 'app_list.dart';

enum PanelOptions { first, previous, next, last, remove }

extension PanelOptionsExtension on PanelOptions {
  String get name {
    switch (this) {
      case PanelOptions.first:
        return "First";
      case PanelOptions.previous:
        return "Previous";
      case PanelOptions.next:
        return "Next";
      case PanelOptions.last:
        return "Last";
      case PanelOptions.remove:
        return "Remove";
    }
  }

  void onTap(int index) {
    var service = GetIt.I.get<PanelService>();
    switch (this) {
      case PanelOptions.first:
        service.toFirst(index);
        break;
      case PanelOptions.previous:
        service.toPrevious(index);
        break;
      case PanelOptions.next:
        service.toNext(index);
        break;
      case PanelOptions.last:
        service.toLast(index);
        break;
      case PanelOptions.remove:
        service.removePanel(index);
        break;
    }
  }
}

@immutable
class PanelLayout {
  final List<Panel> panels;
  PanelLayout({List<Panel> panels = const []}) : panels = List<Panel>.unmodifiable(panels);
  PanelLayout.fromJson(Map<String, dynamic> json)
      : panels = List<Map<String, dynamic>>.from((json['panels'] as List<dynamic>?) ?? []).map((e) {
          switch (e['type']) {
            case "search-bar":
              return SearchBarPanel.fromJson(e);
            case "app-list":
              return AppListPanel.fromJson(e);
            case "empty":
            default:
              return EmptyPanel.fromJson(e);
          }
        }).toList();

  Map<String, dynamic> toJson() => {"panels": panels.map((e) => e.toJson()).toList()};

  PanelLayout copyWith({List<Panel>? panels}) => PanelLayout(panels: panels ?? this.panels);
}
