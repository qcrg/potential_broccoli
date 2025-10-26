import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';
import 'package:potential_broccoli/models/database/users.dart';
import 'package:potential_broccoli/models/locale.dart';
import 'package:potential_broccoli/routes/add_user/form_model.dart';
import 'package:potential_broccoli/routes/add_user/submit.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserState();
}

class _AddUserState extends State<AddUserForm> {
  @override
  Widget build(BuildContext bctx) {
    final l = AppLocalizations.of(bctx)!;
    final locale_model = Provider.of<LocaleModel>(bctx);
    final form_model = Provider.of<FormModel>(bctx);
    final form = form_model.form;
    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          spacing: 16,
          children: [
            ReactiveTextField(
              scrollPadding: EdgeInsets.all(30),
              decoration: _build_input_decoration(l.full_name, required: true),
              formControlName: UserFields.full_name,
            ),
            ReactiveTextField(
              decoration: _build_input_decoration(l.nickname),
              formControlName: UserFields.nickname,
            ),
            Row(
              children: [
                Expanded(
                  child: ReactiveTextField<DateTime>(
                    onTap: (FormControl<DateTime> ctrl) async {
                      DateTime? data = await showDatePicker(
                        context: bctx,
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (data == null) return;
                      setState(() {
                        form.control(UserFields.birthday).value = data;
                      });
                    },
                    decoration: _build_input_decoration(
                      l.birthday,
                      required: true,
                      suffix: Icon(Icons.edit_calendar_outlined),
                    ),
                    formControlName: UserFields.birthday,
                    readOnly: true,
                    mouseCursor: SystemMouseCursors.click,
                    valueAccessor: DateTimeValueAccessor(
                      dateTimeFormat: DateFormat.yMMMMd(
                        locale_model.locale.languageCode,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SubmitButton(child: Text(l.add)),
          ],
        ),
      ),
    );
  }
}

InputDecoration _build_input_decoration(
  String label, {
  bool required = false,
  Widget? suffix,
}) {
  final Widget label_widget = required ? Text("$label*") : Text(label);
  return InputDecoration(
    label: label_widget,
    border: OutlineInputBorder(),
    alignLabelWithHint: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    suffix: suffix,
  );
}
