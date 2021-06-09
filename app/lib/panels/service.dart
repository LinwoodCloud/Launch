import 'dart:convert';

import 'package:linwood_launcher_app/panels/layout.dart';
import 'package:linwood_launcher_app/panels/search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'panel.dart';

class PanelService {
  SharedPreferences prefs;
  PanelLayout panelLayout = PanelLayout();

  List<SearchEngine> get searchEngines => (prefs.getStringList("search-engines") ?? [])
      .map((e) => SearchEngine.fromJson(json.decode(e) as Map<String, dynamic>))
      .toList();
  set searchEngines(List<SearchEngine> value) =>
      prefs.setStringList("search-engines", value.map((e) => json.encode(e.toJson())).toList());

  PanelService(this.prefs) {
    loadPrefs();
  }
  void loadPrefs() {
    panelLayout = PanelLayout.fromJson(
        json.decode(prefs.getString("panel-layout") ?? "{}") as Map<String, dynamic>);
  }

  void updatePanel(Panel oldPanel, Panel newPanel) {
    int index = panelLayout.panels.indexOf(oldPanel);
    if (index >= 0) {
      var panels = List<Panel>.from(panelLayout.panels);
      panels[index] = newPanel;
      panelLayout = panelLayout.copyWith(panels: panels);
    }
  }
}
