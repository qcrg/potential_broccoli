import 'package:flutter/material.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';
import 'package:potential_broccoli/routes/settings/appearance.dart';
import 'package:potential_broccoli/routes/settings/general.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext bctx) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(bctx)!.settings)),
      body: ListView(
        shrinkWrap: true,
        children: [const General(), const Divider(), const Appearance()],
      ),
    );
  }
}
