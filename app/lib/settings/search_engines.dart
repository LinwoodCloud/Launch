import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linwood_launcher_app/panels/search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchEnginesSettingsPage extends StatefulWidget {
  const SearchEnginesSettingsPage({Key? key}) : super(key: key);

  @override
  _SearchEnginesSettingsPageState createState() =>
      _SearchEnginesSettingsPageState();
}

class _SearchEnginesSettingsPageState extends State<SearchEnginesSettingsPage> {
  List<SearchEngine> searchEngines = [];
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();

    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() => searchEngines = _prefs
            .getStringList("search-engines")
            ?.map((e) => SearchEngine.fromJson(json.decode(e)))
            .toList() ??
        []);
  }

  Future<void> saveSearchEngines() => _prefs.setStringList("search-engines",
      searchEngines.map((e) => json.encode(e.toJson())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Search engines")),
        body: ListView.builder(
          itemCount: searchEngines.length,
          itemBuilder: (context, index) => Dismissible(
            key: Key(searchEngines[index].queryUrl),
            onDismissed: (direction) {
              searchEngines.removeAt(index);
              saveSearchEngines();
            },
            background: Container(color: Colors.red),
            child: ListTile(
                title: Text(searchEngines[index].name),
                subtitle: Text(searchEngines[index].queryUrl)),
          ),
        ));
  }
}
