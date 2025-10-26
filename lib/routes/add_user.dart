import 'package:flutter/material.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';
import 'package:potential_broccoli/models/users.dart';
import 'package:potential_broccoli/routes/add_user/form.dart';
import 'package:potential_broccoli/routes/add_user/form_model.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext bctx) {
    final l = AppLocalizations.of(bctx)!;
    return ChangeNotifierProvider(
      create: (_) =>
          FormModel(bmodel: Provider.of<UsersModel>(bctx, listen: false)),
      builder: (BuildContext bctx, Widget? _) {
        return Scaffold(
          appBar: AppBar(title: Text(l.add_user)),
          body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool did_pop, Object? _) async {
              if (did_pop) {
                return;
              }
              final should_pop = await _should_pop(bctx);
              if (should_pop && bctx.mounted) {
                Navigator.of(bctx).pop();
              }
            },
            child: Center(child: AddUserForm()),
          ),
        );
      },
    );
  }

  Future<bool> _should_pop(BuildContext bctx) async {
    final form = Provider.of<FormModel>(bctx, listen: false).form;
    for (var ctrl in form.controls.values) {
      if (ctrl.isNull) continue;
      if (ctrl.value is DateTime || !_dyn_is_empty_string(ctrl.value)) {
        return await _show_confirmation_dialog(bctx) ?? false;
      }
    }
    return Future.value(true);
  }

  Future<bool?> _show_confirmation_dialog(BuildContext bctx) async {
    return showDialog<bool>(
      context: bctx,
      builder: (BuildContext context) {
        final l = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l.are_you_sure),
          content: Text(l.has_unsaved_data),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(l.cancel),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(l.leave),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}

bool _dyn_is_empty_string(dynamic dyn) {
  return dyn is String && dyn.isEmpty;
}
