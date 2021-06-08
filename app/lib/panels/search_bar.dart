import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linwood_launcher_app/panels/panel.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchEngine {
  final String name;
  final String queryUrl;

  static const defaultEngines = const [
    SearchEngine(name: "Google", queryUrl: "https://google.com/search?q=%s"),
    SearchEngine(name: "Ecosia", queryUrl: "https://ecosia.com/search?q=%"),
    SearchEngine(
        name: "Wikipedia",
        queryUrl: "https://wikipedia.org/w/index.php?search=%s&ns0=1"),
    SearchEngine(name: "Amazon", queryUrl: "https://amazon.com/s?k=%s"),
    SearchEngine(name: "Bing", queryUrl: "https://bing.com/search?q=%s"),
    SearchEngine(
        name: "Pixabay", queryUrl: "https://pixabay.com/images/search/%s"),
    SearchEngine(name: "DuckDuckGo", queryUrl: "https://duckduckgo.com/?q=%s"),
    SearchEngine(name: "Ebay", queryUrl: "https://ebay.com/sch/?_nkw=%s"),
  ];

  const SearchEngine({required this.name, required this.queryUrl});
  SearchEngine.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        queryUrl = json['query-url'];

  Map<String, dynamic> toJson() => {"name": name, "query-url": queryUrl};
}

class SearchBarPanel extends Panel {
  SearchEngine searchEngine;

  SearchBarPanel(this.searchEngine);

  SearchBarPanel.fromJson(Map<String, dynamic> json)
      : searchEngine = SearchEngine.fromJson(json['search-engine']),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {"search-engine": searchEngine.toJson()};

  @override
  Widget buildWidget(BuildContext context) => SearchBarWidget(panel: this);
}

class SearchBarWidget extends StatefulWidget {
  final SearchBarPanel panel;
  const SearchBarWidget({Key? key, required this.panel}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    void submit() {
      if (_controller.text.isNotEmpty)
        launch(sprintf(widget.panel.searchEngine.queryUrl,
            [Uri.encodeQueryComponent(_controller.text)]));
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
                          labelText:
                              "Search with ${widget.panel.searchEngine.name}"),
                      controller: _controller,
                      onSubmitted: (value) => submit())),
              IconButton(
                  icon: Icon(PhosphorIcons.magnifyingGlassLight),
                  onPressed: submit),
              PopupMenuButton<SearchEngine>(
                  onSelected: (value) =>
                      setState(() => widget.panel.searchEngine = value),
                  itemBuilder: (context) => [
                        ...SearchEngine.defaultEngines.map(
                            (e) => PopupMenuItem(child: Text(e.name), value: e))
                      ])
            ])));
  }
}
