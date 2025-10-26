import 'package:flutter/cupertino.dart';
import 'package:potential_broccoli/models/users.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:potential_broccoli/models/database/users.dart';

class FormModel extends ChangeNotifier {
  final FormGroup form;

  FormModel({required UsersModel bmodel})
    : form = FormGroup({
        UserFields.full_name: FormControl<String>(
          validators: [
            Validators.required,
            Validators.maxLength(UserFieldMaxLengths.full_name),
            _FullNameUniqueValidator(bmodel),
          ],
        ),
        UserFields.nickname: FormControl<String>(
          validators: [Validators.maxLength(UserFieldMaxLengths.nickname)],
        ),
        UserFields.birthday: FormControl<DateTime>(
          validators: [Validators.required],
        ),
      });
}

class _FullNameUniqueValidator extends Validator<dynamic> {
  static const String _error_name = "already_added";

  final UsersModel bmodel;

  _FullNameUniqueValidator(this.bmodel) : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> raw_ctrl) {
    final ctrl = raw_ctrl as FormControl<String>;
    final String? full_name = ctrl.value;
    if (full_name == null) {
      return null;
    }
    final has_user = bmodel.has_user_with_full_name(full_name);
    if (has_user) {
      ctrl.markAsTouched();
      return {_error_name: true};
    }
    return null;
  }
}
