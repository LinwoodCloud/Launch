import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:linwood_launcher_app/panels/panel.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'layout.dart';
import 'service.dart';

class SearchEngine {
  final String name;
  final String queryUrl;

  static const defaultEngines = [
    SearchEngine(name: 'Google', queryUrl: 'https://google.com/search?q=%s'),
    SearchEngine(name: 'Ecosia', queryUrl: 'https://ecosia.com/search?q=%'),
    SearchEngine(
        name: 'Wikipedia',
        queryUrl: 'https://wikipedia.org/w/index.php?search=%s&ns0=1'),
    SearchEngine(name: 'Amazon', queryUrl: 'https://amazon.com/s?k=%s'),
    SearchEngine(name: 'Bing', queryUrl: 'https://bing.com/search?q=%s'),
    SearchEngine(
        name: 'Pixabay', queryUrl: 'https://pixabay.com/images/search/%s'),
    SearchEngine(name: 'DuckDuckGo', queryUrl: 'https://duckduckgo.com/?q=%s'),
    SearchEngine(name: 'Ebay', queryUrl: 'https://ebay.com/sch/?_nkw=%s'),
  ];

  const SearchEngine({required this.name, required this.queryUrl});
  SearchEngine.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        queryUrl = json['query-url'] as String;

  Map<String, dynamic> toJson() => {'name': name, 'query-url': queryUrl};
}

class SearchBarPanel extends Panel {
  final SearchEngine searchEngine;

  const SearchBarPanel({required this.searchEngine});

  SearchBarPanel.fromJson(super.json)
      : searchEngine = SearchEngine.fromJson(
            json['search-engine'] as Map<String, dynamic>),
        super.fromJson();

  @override
  Map<String, dynamic> toJson() =>
      {'search-engine': searchEngine.toJson(), 'type': 'search-bar'};

  @override
  Widget buildWidget(
          PanelLayout panelLayout, int index, BuildContext context) =>
      SearchBarWidget(panelLayout: panelLayout, index: index);

  SearchBarPanel copyWith({SearchEngine? searchEngine}) =>
      SearchBarPanel(searchEngine: searchEngine ?? this.searchEngine);
}

class SearchBarWidget extends StatefulWidget {
  final int index;
  final PanelLayout panelLayout;
  const SearchBarWidget(
      {super.key, required this.index, required this.panelLayout});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late PanelService service;
  late SearchBarPanel panel;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<PanelService>();
    panel = service.panelLayout.panels[widget.index] as SearchBarPanel;
  }

  @override
  void didUpdateWidget(SearchBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      panel = service.panelLayout.panels[widget.index] as SearchBarPanel;
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    var searchEngines = service.searchEngines;
    void submit() {
      if (controller.text.isNotEmpty) {
        launchUrlString(sprintf(panel.searchEngine.queryUrl,
            [Uri.encodeQueryComponent(controller.text)]));
        controller.text = '';
      }
    }

    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Row(children: [
              Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Search with ${panel.searchEngine.name}'),
                      controller: controller,
                      onSubmitted: (value) => submit())),
              IconButton(
                  icon: const Icon(PhosphorIcons.magnifyingGlassLight),
                  onPressed: submit),
              StreamBuilder<bool>(
                  stream: service.editChanged,
                  initialData: service.editing,
                  builder: (context, snapshot) => !(snapshot.data!)
                      ? Container()
                      : PopupMenuButton<VoidCallback>(
                          onSelected: (value) => value(),
                          itemBuilder: (context) => [
                                ...searchEngines
                                    .map((e) => PopupMenuItem(
                                        child: Text(e.name),
                                        value: () => setState(() {
                                              panel = panel.copyWith(
                                                  searchEngine: e);
                                              service.updatePanel(
                                                  widget.index, panel);
                                            })))
                                    .toList(),
                                const PopupMenuDivider(),
                                ...PanelOptions.values
                                    .map((e) => PopupMenuItem(
                                        child: Text(e.name),
                                        value: () => e.onTap(widget.index)))
                                    .toList()
                              ]))
            ])));
  }
}
