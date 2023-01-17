import 'package:flutter/material.dart';
import 'package:linwood_launcher_app/theme.dart';

class PersonalizationSettingsPage extends StatefulWidget {
  const PersonalizationSettingsPage({super.key});

  @override
  _PersonalizationSettingsPageState createState() =>
      _PersonalizationSettingsPageState();
}

class _PersonalizationSettingsPageState
    extends State<PersonalizationSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Personalization')),
        body: Builder(
          builder: (context) => ListView(children: [
            ListTile(
                title: const Text('Theme'),
                subtitle: Text(
                    ThemeController.of(context)?.currentTheme.toString() ?? ''),
                onTap: () => _openThemeModal())
          ]),
        ));
  }

  void _openThemeModal() async {
    final themeController = ThemeController.of(context);
    var currentTheme = themeController?.currentTheme;
    var themeMode = await showModalBottomSheet<ThemeMode>(
        context: context,
        builder: (context) {
          return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    'Theme',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                    title: const Text('System'),
                    selected: currentTheme == ThemeMode.system,
                    leading: const Icon(Icons.settings_outlined),
                    onTap: () => Navigator.of(context).pop(ThemeMode.system)),
                ListTile(
                    title: const Text('Light'),
                    selected: currentTheme == ThemeMode.light,
                    leading: const Icon(Icons.wb_sunny_outlined),
                    onTap: () => Navigator.of(context).pop(ThemeMode.light)),
                ListTile(
                    title: const Text('Dark'),
                    selected: currentTheme == ThemeMode.dark,
                    leading: const Icon(Icons.nightlight_round),
                    onTap: () => Navigator.of(context).pop(ThemeMode.dark)),
                const SizedBox(height: 32),
              ]));
        });
    if (themeMode != null) {
      themeController?.currentTheme = themeMode;
    }
  }
}
