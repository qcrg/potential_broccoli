import 'package:flutter/material.dart';
import 'package:potential_broccoli/models/users.dart';
import 'package:potential_broccoli/models/database/users.dart';
import 'package:potential_broccoli/routes/add_user/form_model.dart';
import 'package:potential_broccoli/routes/add_user/user_added_dialog.dart';
import 'package:potential_broccoli/routes/add_user/user_not_added_alert.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatefulWidget {
  final Widget? child;
  final Widget? progress_child;

  const SubmitButton({super.key, this.child, this.progress_child});

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _loading;

  _SubmitButtonState() : _loading = false;

  @override
  Widget build(BuildContext bctx) {
    if (_loading) {
      return ElevatedButton(
        onPressed: null,
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () => _on_submit(bctx),
        child: widget.child,
      );
    }
  }

  void _on_submit(BuildContext bctx) async {
    final form_model = Provider.of<FormModel>(bctx, listen: false);
    final form = form_model.form;
    form.markAllAsTouched();
    form.updateValueAndValidity();
    for (var ctrl in form.controls.values) {
      if (!ctrl.valid) {
        ctrl.focus();
        return;
      }
    }
    setState(() {
      _loading = true;
    });

    final model = Provider.of<UsersModel>(bctx, listen: false);
    final user = User.fromMap(form.value);
    final ans = await model.insert(user);
    setState(() {
      _loading = false;
    });
    if (!bctx.mounted) {
      assert(bctx.mounted, "Must be mounted");
      return;
    }
    if (ans == null) {
      await showDialog(
        context: bctx,
        builder: (BuildContext bctx) {
          return UserAddedDialog();
        },
      );
      if (bctx.mounted) Navigator.of(bctx).pop();
    } else {
      await showDialog(
        context: bctx,
        builder: (BuildContext bctx) {
          return UserNotAddedAlert();
        },
      );
    }
  }
}
