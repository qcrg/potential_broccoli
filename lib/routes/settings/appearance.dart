import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';
import 'package:potential_broccoli/models.dart';
import 'package:potential_broccoli/routes/settings/group_name.dart';
import 'package:provider/provider.dart';

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext bctx) {
    var l = AppLocalizations.of(bctx)!;
    return Column(
      children: [
        GroupName(l.settings_group_appearance),
        ListTile(
          leading: Icon(Icons.style_outlined),
          title: Text(l.settings_theme),
          subtitle: Text(l.settings_description_theme),
          trailing: ChangeThemeButton(),
        ),
      ],
    );
  }
}

const double _icon_padding = 6;

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});
  @override
  Widget build(BuildContext bctx) {
    return Consumer<ThemeModeModel>(
      builder: (_, model, _) {
        var l = AppLocalizations.of(bctx)!;
        return DropdownButtonHideUnderline(
          child: DropdownButton2<ThemeMode>(
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
            value: model.theme_mode,
            items: [
              DropdownMenuItem<ThemeMode>(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    Icon(Icons.dark_mode_outlined),
                    SizedBox(width: _icon_padding),
                    Text(l.theme_dark),
                  ],
                ),
              ),
              DropdownMenuItem<ThemeMode>(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    Icon(Icons.light_outlined),
                    SizedBox(width: _icon_padding),
                    Text(l.theme_light),
                  ],
                ),
              ),
              DropdownMenuItem<ThemeMode>(
                value: ThemeMode.system,
                child: Row(
                  children: [
                    Icon(Icons.desktop_windows_outlined),
                    SizedBox(width: _icon_padding),
                    Text(l.theme_system),
                  ],
                ),
              ),
            ],
            onChanged: (ThemeMode? val) {
              if (val != null) model.theme_mode = val;
            },
          ),
        );
      },
    );
  }
}
