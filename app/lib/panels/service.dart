import 'dart:async';
import 'dart:convert';

import 'package:linwood_launcher_app/panels/layout.dart';
import 'package:linwood_launcher_app/panels/search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'panel.dart';

class PanelService {
  SharedPreferences prefs;
  PanelLayout get panelLayout =>
      PanelLayout.fromJson(json.decode(prefs.getString("layout") ?? "{}") as Map<String, dynamic>);
  set panelLayout(PanelLayout value) {
    prefs.setString("layout", json.encode(value.toJson()));
    _panelController.add(value);
  }

  List<SearchEngine> get searchEngines => (prefs.getStringList("search-engines") ?? [])
      .map((e) => SearchEngine.fromJson(json.decode(e) as Map<String, dynamic>))
      .toList();
  set searchEngines(List<SearchEngine> value) =>
      prefs.setStringList("search-engines", value.map((e) => json.encode(e.toJson())).toList());
  final StreamController<PanelLayout> _panelController = StreamController.broadcast();

  Stream<PanelLayout> get panelChanged => _panelController.stream;
  bool _editing = false;
  bool get editing => _editing;
  set editing(bool value) {
    _editing = value;
    _editingController.add(_editing);
  }

  final StreamController<bool> _editingController = StreamController.broadcast();

  Stream<bool> get editChanged => _editingController.stream;

  PanelService(this.prefs);

  void updatePanel(int index, Panel panel) {
    var panels = List<Panel>.from(panelLayout.panels);
    panels[index] = panel;
    panelLayout = panelLayout.copyWith(panels: panels);
  }

  void addPanel(Panel panel) {
    var panels = List<Panel>.from(panelLayout.panels);
    panels.add(panel);
    panelLayout = panelLayout.copyWith(panels: panels);
  }

  void removePanel(int index) {
    var panels = List<Panel>.from(panelLayout.panels);
    print(panels.removeAt(index));
    panelLayout = panelLayout.copyWith(panels: panels);
  }

  void toFirst(int index) {
    var panels = List<Panel>.from(panelLayout.panels);
    var panel = panels.removeAt(index);
    print(panel);
    panels.insert(0, panel);
    panelLayout = panelLayout.copyWith(panels: panels);
  }

  void toLast(int index) {
    var panels = List<Panel>.from(panelLayout.panels);
    var panel = panels.removeAt(index);
    panels.add(panel);
    panelLayout = panelLayout.copyWith(panels: panels);
  }

  void toPrevious(int index) {
    var panels = List<Panel>.from(panelLayout.panels);
    var panel = panels.removeAt(index);
    panels.insert(index - 1, panel);
    panelLayout = panelLayout.copyWith(panels: panels);
  }

  void toNext(int index) {
    var panels = List<Panel>.from(panelLayout.panels);
    var panel = panels.removeAt(index);
    if (index < panels.length) {
      panels.insert(index + 1, panel);
      panelLayout = panelLayout.copyWith(panels: panels);
    }
  }
}
