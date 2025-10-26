import 'package:flutter/material.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';
import 'package:potential_broccoli/models.dart';
import 'package:potential_broccoli/routes/settings/group_name.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class General extends StatelessWidget {
  const General({super.key});

  @override
  Widget build(BuildContext bctx) {
    var l = AppLocalizations.of(bctx)!;
    return Column(
      children: [
        GroupName(l.settings_group_general),
        ListTile(
          leading: Icon(Icons.language),
          title: Text(l.settings_language),
          subtitle: Text(l.settings_description_language),
          trailing: ChangeLanguageButton(),
        ),
      ],
    );
  }
}

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});
  @override
  Widget build(BuildContext bctx) {
    return Consumer<LocaleModel>(
      builder: (_, model, _) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<Locale>(
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            value: model.locale,
            items: AppLocalizations.supportedLocales
                .map<DropdownMenuItem<Locale>>((Locale loc) {
                  return DropdownMenuItem<Locale>(
                    value: loc,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(lookupAppLocalizations(loc).language),
                    ),
                  );
                })
                .toList(),
            onChanged: (Locale? val) {
              if (val != null) model.locale = val;
            },
          ),
        );
      },
    );
  }
}
