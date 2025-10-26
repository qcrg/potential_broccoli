import "dart:io";

import "package:flutter/material.dart";
import "package:potential_broccoli/l10n/app_localizations.dart";
import "package:potential_broccoli/log.dart";
import "package:shared_preferences/shared_preferences.dart";

class _Key {
  static const locale_code = "locale_code";
  static const theme_mode = "theme_mode";
}

class _Default {
  static const locale_code = "en";
  static const theme_mode = ThemeMode.system;
}

class Settings {
  final SharedPreferencesWithCache _prefs;
  final ThemeMode _default_theme_mode;
  late String _default_locale_code;

  Settings._(
    this._prefs,
    this._default_theme_mode,
    String? default_locale_code,
  ) {
    if (default_locale_code != null) {
      assert(
        AppLocalizations.supportedLocales.contains(Locale(default_locale_code)),
        "Locale is not supported",
      );
      _default_locale_code = default_locale_code;
      return;
    }

    final platform_locale_name = Platform.localeName.split("_")[0];
    if (AppLocalizations.supportedLocales.contains(
      Locale(platform_locale_name),
    )) {
      _default_locale_code = platform_locale_name;
      return;
    }

    log.w(
      "Platform locale '$platform_locale_name' is not supported."
      "Use default locale '${_Default.locale_code}'",
    );
    _default_locale_code = _Default.locale_code;
  }

  static Future<Settings> create({
    ThemeMode? default_theme_mode,
    String? default_locale_code,
  }) async {
    var spwc = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    return Settings._(
      spwc,
      default_theme_mode ?? _Default.theme_mode,
      default_locale_code,
    );
  }

  Locale get locale {
    if (_prefs.containsKey(_Key.locale_code)) {
      var code = _prefs.getString(_Key.locale_code)!;
      assert(AppLocalizations.supportedLocales.contains(Locale(code)));
      return Locale(code);
    }
    return Locale(_default_locale_code);
  }

  set locale(Locale locale) {
    assert(
      AppLocalizations.supportedLocales.contains(locale),
      "Locale '${locale.languageCode}' is not supported",
    );
    _prefs.setString(_Key.locale_code, locale.languageCode);
  }

  ThemeMode get theme_mode {
    final int? mode = _prefs.getInt(_Key.theme_mode);
    if (mode == null || mode < 0 || mode >= ThemeMode.values.length) {
      return _default_theme_mode;
    }
    return ThemeMode.values[mode];
  }

  set theme_mode(ThemeMode mode) {
    _prefs.setInt(_Key.theme_mode, mode.index);
  }
}
