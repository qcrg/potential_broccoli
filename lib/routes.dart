import "package:flutter/widgets.dart";
import "package:potential_broccoli/routes/add_user.dart";

import "package:potential_broccoli/routes/home.dart";
import "package:potential_broccoli/routes/settings.dart";

enum Routes {
  home,
  settings,
  add_user;

  String route() {
    const routes = <String>["/", "/settings", "/add_user"];
    return routes[index];
  }
}

final predefined_routes = Map<String, WidgetBuilder>.unmodifiable({
  Routes.home.route(): (_) => Home(key: Key("home-page")),
  Routes.settings.route(): (_) => Settings(key: Key("settings-page")),
  Routes.add_user.route(): (_) => AddUser(key: Key("add_user-page")),
});
