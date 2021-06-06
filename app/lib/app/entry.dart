typedef void AppCallback();

class AppEntry {
  final String name;
  final String description;
  final AppCallback onTap;

  AppEntry(this.name, {this.description = "", required this.onTap});
}

class WebEntry extends AppEntry {
  final String url;
  WebEntry(String name, {String description = "", required this.url})
      : super(name, description: description, onTap: () {
          print(url);
        });
}

class CommandEntry extends AppEntry {
  final String command;
  CommandEntry(String name, {String description = "", required this.command})
      : super(name, description: description, onTap: () {
          print(command);
        });
}
