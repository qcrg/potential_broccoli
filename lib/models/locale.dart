import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:potential_broccoli/models/settings.dart';

class LocaleModel with ChangeNotifier {
  final Settings _settings;

  LocaleModel({required Settings settings}) : _settings = settings;

  Locale get locale => _settings.locale;
  set locale(Locale new_loc) {
    _settings.locale = new_loc;
    notifyListeners();
  }
}
