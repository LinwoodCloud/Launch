import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:linwood_launcher_app/panels/panel.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import 'layout.dart';
import 'service.dart';

class SearchEngine {
  final String name;
  final String queryUrl;

  static const defaultEngines = [
    SearchEngine(name: "Google", queryUrl: "https://google.com/search?q=%s"),
    SearchEngine(name: "Ecosia", queryUrl: "https://ecosia.com/search?q=%"),
    SearchEngine(name: "Wikipedia", queryUrl: "https://wikipedia.org/w/index.php?search=%s&ns0=1"),
    SearchEngine(name: "Amazon", queryUrl: "https://amazon.com/s?k=%s"),
    SearchEngine(name: "Bing", queryUrl: "https://bing.com/search?q=%s"),
    SearchEngine(name: "Pixabay", queryUrl: "https://pixabay.com/images/search/%s"),
    SearchEngine(name: "DuckDuckGo", queryUrl: "https://duckduckgo.com/?q=%s"),
    SearchEngine(name: "Ebay", queryUrl: "https://ebay.com/sch/?_nkw=%s"),
  ];

  const SearchEngine({required this.name, required this.queryUrl});
  SearchEngine.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        queryUrl = json['query-url'] as String;

  Map<String, dynamic> toJson() => {"name": name, "query-url": queryUrl};
}

class SearchBarPanel extends Panel {
  final SearchEngine searchEngine;

  SearchBarPanel({required this.searchEngine});

  SearchBarPanel.fromJson(Map<String, dynamic> json)
      : searchEngine = SearchEngine.fromJson(json['search-engine'] as Map<String, dynamic>),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {"search-engine": searchEngine.toJson(), "type": "search-bar"};

  @override
  Widget buildWidget(PanelLayout panelLayout, BuildContext context) =>
      SearchBarWidget(panelLayout: panelLayout, panel: this);

  SearchBarPanel copyWith({SearchEngine? searchEngine}) =>
      SearchBarPanel(searchEngine: searchEngine ?? this.searchEngine);
}

class SearchBarWidget extends StatefulWidget {
  final SearchBarPanel panel;
  final PanelLayout panelLayout;
  const SearchBarWidget({Key? key, required this.panel, required this.panelLayout})
      : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  List<SearchEngine> searchEngines = [];
  late PanelService service;
  late SearchBarPanel panel;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<PanelService>();
    panel = widget.panel;
  }

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    void submit() {
      if (_controller.text.isNotEmpty) {
        launch(sprintf(
            widget.panel.searchEngine.queryUrl, [Uri.encodeQueryComponent(_controller.text)]));
        _controller.text = "";
      }
    }

    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            constraints: BoxConstraints(maxWidth: 1000),
            child: Row(children: [
              Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Search with ${widget.panel.searchEngine.name}"),
                      controller: _controller,
                      onSubmitted: (value) => submit())),
              IconButton(icon: Icon(PhosphorIcons.magnifyingGlassLight), onPressed: submit),
              PopupMenuButton<SearchEngine>(
                  onSelected: (value) => setState(() {
                        var oldPanel = panel;
                        panel = widget.panel.copyWith(searchEngine: value);
                        service.updatePanel(oldPanel, panel);
                      }),
                  itemBuilder: (context) =>
                      [...searchEngines.map((e) => PopupMenuItem(child: Text(e.name), value: e))])
            ])));
  }
}
