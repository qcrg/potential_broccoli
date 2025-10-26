import 'package:flutter/material.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';

class UserNotAddedAlert extends StatelessWidget {
  const UserNotAddedAlert({super.key});

  @override
  Widget build(BuildContext bctx) {
    final l = AppLocalizations.of(bctx)!;
    return AlertDialog(
      title: Text(l.user_is_not_added),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [Text(l.internal_error), Text(l.dont_worry_old_data_ok)],
      ),
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
