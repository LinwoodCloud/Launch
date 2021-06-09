import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:linwood_launcher_app/panels/search_bar.dart';
import 'package:linwood_launcher_app/panels/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'theme.dart';

void main() async {
  // load the shared preferences from disk before the app is started
  final prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton(PanelService(prefs));

  if (!prefs.containsKey("search-engines")) {
    prefs.setStringList(
        "search-engines", SearchEngine.defaultEngines.map((e) => json.encode(e.toJson())).toList());
  }

  // create new theme controller, which will get the currently selected from shared preferences
  final themeController = ThemeController(prefs);

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController? themeController;

  const MyApp({Key? key, this.themeController}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (themeController != null) {
      return AnimatedBuilder(
          animation: themeController!,
          builder: (context, _) {
            // wrap app in inherited widget to provide the ThemeController to all pages
            return ThemeControllerProvider(controller: themeController!, child: _buildApp());
          });
    }
    return _buildApp();
  }

  Widget _buildApp() => MaterialApp(
        title: 'Linwood Launcher',
        themeMode: themeController?.currentTheme,
        theme: ThemeData(primarySwatch: Colors.blue),
        darkTheme: ThemeData(
            brightness: Brightness.dark, primarySwatch: Colors.blue, primaryColor: Colors.blue),
        home: HomePage(),
      );
}
