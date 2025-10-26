import 'package:intl/intl.dart';

import 'utils.dart';

class UserFields {
  static const String table_name_ = "users";
  static const String id = "id";
  static const String full_name = "full_name";
  static const String nickname = "nickname";
  static const String birthday = "birthday";
}

class UserFieldMaxLengths {
  static const int full_name = 128;
  static const int nickname = 32;
}

class User {
  final int? id;
  final String full_name;
  final String? nickname;
  final DateTime birthday;

  User({
    this.id,
    required this.full_name,
    this.nickname,
    required this.birthday,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    var bval = map[UserFields.birthday];
    DateTime birthday;
    if (bval is String) {
      birthday = DateTime.parse(bval.replaceAll(".", "-"));
    } else {
      birthday = bval as DateTime;
    }
    return User(
      id: map[UserFields.id] as int?,
      full_name: map[UserFields.full_name] as String,
      nickname: map[UserFields.nickname] as String?,
      birthday: birthday,
    );
  }

  Map<String, dynamic> toMap() {
    final res = <String, dynamic>{
      UserFields.full_name: full_name,
      UserFields.birthday: DateFormat("yyyy.MM.dd").format(birthday),
    };
    res
      ..set_if_not_null(UserFields.id, id)
      ..set_if_not_null(UserFields.nickname, nickname);
    return res;
  }

  @override
  String toString() {
    var buf = StringBuffer();
    buf.write("User(");
    if (id != null) buf.write("${UserFields.id}=$id, ");
    buf.write("${UserFields.full_name}='$full_name', ");
    if (nickname != null) buf.write("${UserFields.nickname}='$nickname', ");
    buf.write("birthday='${DateFormat("dd-MM-yyyy").format(birthday)}'");
    buf.write(")");
    return buf.toString();
  }
}
