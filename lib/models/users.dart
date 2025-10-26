import 'package:flutter/material.dart';
import 'package:potential_broccoli/constants.dart';
import 'package:potential_broccoli/errors.dart';
import 'package:potential_broccoli/log.dart';
import 'package:potential_broccoli/models/database.dart';
import 'package:potential_broccoli/models/database/users.dart';

class UsersModel with ChangeNotifier {
  final _data = _UsersData();
  final DB _db;

  UsersModel({required DB database}) : _db = database {
    _init();
  }

  void _init() async {
    var users = await _db.get_users();
    users.forEach(_data.insert);
    if (_data.length != 0) notifyListeners();
    log.d("UsersModel is initiated. length=${_data.length}");
  }

  Iterable<User> get_month(Months month) {
    return _data.get_month(month);
  }

  FutErr insert(User user) async {
    final old_len = _data.length;
    if (_data.insert(user)) {
      final res = await _db.insert_user(user).then((ErrType? err) {
        if (err == null) return;
        log.e("$user is not added", error: err);
      });
      if (res == null) {
        notifyListeners();
      }
      return res;
    }
    log.d("Insert in UsersModel. old_len=$old_len length=${_data.length}");
    return null;
  }

  FutErr remove(User user) async {
    final old_len = _data.length;
    if (_data.remove(user)) {
      final res = await _db.delete_user(user).then((ErrType? err) {
        if (err == null) return;
        log.e("$user is not removed", error: err);
      });
      if (res == null) {
        notifyListeners();
      }
      return res;
    }
    log.d("Remove from UsersModel. old_len=$old_len length=${_data.length}");
    return null;
  }

  bool has_user_with_full_name(String full_name) {
    return _data.has_user_with_full_name(full_name);
  }
}

class _UsersData {
  final _data = List<Set<User>>.generate(Months.values.length, (_) => <User>{});
  final _full_names = <String>{};

  // return: is changed
  bool insert(User user) {
    log.d("Inserting user: $user");
    final month = _data[Months.fromDateTime(user.birthday).index];
    final res = month.add(user);
    if (res) {
      _full_names.add(user.full_name);
      log.d("User inserted: $user; $_data");
    }
    return res;
  }

  // return: is changed
  bool remove(User user) {
    final month = _data[Months.fromDateTime(user.birthday).index];
    final res = month.remove(user);
    if (res) {
      _full_names.remove(user.full_name);
    }
    return res;
  }

  bool has_user_with_full_name(String full_name) {
    return _full_names.contains(full_name);
  }

  Iterable<User> get_month(Months month) {
    return _data[month.index];
  }

  int get length => _full_names.length;
}
