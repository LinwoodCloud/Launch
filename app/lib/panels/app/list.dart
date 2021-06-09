import 'package:linwood_launcher_app/app/entry.dart';

import '../panel.dart';

abstract class AppListPanel extends Panel {
  List<AppEntry> get apps;
}
