import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../panels/search_bar.dart';
import '../panels/service.dart';

class SearchEnginesSettingsPage extends StatefulWidget {
  const SearchEnginesSettingsPage({super.key});

  @override
  _SearchEnginesSettingsPageState createState() =>
      _SearchEnginesSettingsPageState();
}

class _SearchEnginesSettingsPageState extends State<SearchEnginesSettingsPage> {
  late PanelService service;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<PanelService>();
  }

  @override
  Widget build(BuildContext context) {
    var searchEngines = service.searchEngines;
    return Scaffold(
        appBar: AppBar(title: const Text('Search engines')),
        body: ListView.builder(
            itemCount: searchEngines.length,
            itemBuilder: (context, index) => Dismissible(
                  key: Key(searchEngines[index].queryUrl),
                  onDismissed: (direction) {
                    searchEngines = List<SearchEngine>.from(searchEngines);
                    searchEngines.removeAt(index);
                    service.searchEngines = searchEngines;
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                      title: Text(searchEngines[index].name),
                      subtitle: Text(searchEngines[index].queryUrl)),
                )),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  var nameController = TextEditingController();
                  var queryUrlController = TextEditingController();
                  return AlertDialog(
                      title: const Text('Add search engine'),
                      actions: [
                        TextButton(
                            child: const Text('CANCEL'),
                            onPressed: () => Navigator.of(context).pop()),
                        TextButton(
                            child: const Text('ADD'),
                            onPressed: () {
                              if (nameController.text.isEmpty ||
                                  queryUrlController.text.isEmpty) {
                                return;
                              }
                              searchEngines =
                                  List<SearchEngine>.from(searchEngines);
                              searchEngines.add(SearchEngine(
                                  name: nameController.text,
                                  queryUrl: queryUrlController.text));
                              Navigator.of(context).pop();
                              setState(
                                  () => service.searchEngines = searchEngines);
                            })
                      ],
                      content: SingleChildScrollView(
                          child: Column(children: [
                        TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                labelText: 'Name', hintText: 'DuckDuckGo')),
                        TextField(
                            controller: queryUrlController,
                            decoration: const InputDecoration(
                                labelText: 'Query-URL',
                                hintText: 'https://duckduckgo.com/?q=%s'))
                      ])));
                }),
            label: const Text('Add search engine'),
            icon: const Icon(PhosphorIcons.plusLight)));
  }
}
