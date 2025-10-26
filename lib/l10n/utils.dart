import 'package:potential_broccoli/constants.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';

final _months_map = [
  (AppLocalizations l) => l.january,
  (AppLocalizations l) => l.february,
  (AppLocalizations l) => l.march,
  (AppLocalizations l) => l.april,
  (AppLocalizations l) => l.may,
  (AppLocalizations l) => l.june,
  (AppLocalizations l) => l.july,
  (AppLocalizations l) => l.august,
  (AppLocalizations l) => l.september,
  (AppLocalizations l) => l.october,
  (AppLocalizations l) => l.november,
  (AppLocalizations l) => l.december,
];

extension ConvertWithL10nMonthExtension on Months {
  String translate(AppLocalizations l) {
    return _months_map[index](l);
  }
}
