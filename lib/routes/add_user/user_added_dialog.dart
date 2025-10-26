import 'package:flutter/material.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';

class UserAddedDialog extends StatelessWidget {
  const UserAddedDialog({super.key});

  @override
  Widget build(BuildContext bctx) {
    final l = AppLocalizations.of(bctx)!;
    return AlertDialog(
      title: Center(child: Text(l.user_added)),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(bctx).textTheme.labelLarge,
          ),
          child: Text(l.ok),
          onPressed: () {
            Navigator.pop(bctx, true);
          },
        ),
      ],
    );
  }
}
