import 'package:flutter/material.dart';
import 'package:potential_broccoli/models/settings.dart';

class ThemeModeModel with ChangeNotifier {
  final Settings _settings;

  ThemeModeModel({required Settings settings}) : _settings = settings;

  ThemeMode get theme_mode => _settings.theme_mode;
  set theme_mode(ThemeMode new_mode) {
    _settings.theme_mode = new_mode;
    notifyListeners();
  }
}
