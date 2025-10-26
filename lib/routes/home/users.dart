import 'package:intl/intl.dart';
import 'package:potential_broccoli/models/database/users.dart';
import 'package:flutter/material.dart';
import 'package:potential_broccoli/constants.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';
import 'package:potential_broccoli/l10n/utils.dart';
import 'package:potential_broccoli/models.dart';
import 'package:potential_broccoli/models/users.dart';
import 'package:potential_broccoli/routes/home/users/list_group.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final _ctrl = ItemScrollController();

  @override
  void initState() {
    super.initState();

    var msm = Provider.of<MonthSelectionModel>(context, listen: false);
    msm.addListener(() {
      _ctrl.jumpTo(index: msm.month.index);
    });
  }

  @override
  Widget build(BuildContext bctx) {
    var msm = Provider.of<MonthSelectionModel>(context, listen: false);
    return ScrollablePositionedList.builder(
      itemCount: Months.values.length,
      initialScrollIndex: msm.month.index,
      itemBuilder: _item_builder,
      itemScrollController: _ctrl,
    );
  }
}

Widget _item_builder(BuildContext bctx, int i) {
  final month = Months.fromInt(i);
  return Consumer<UsersModel>(
    builder: (_, model, child) {
      var l = AppLocalizations.of(bctx)!;
      return ListGroup(
        title: month.translate(l),
        selected: month == Months.fromDateTime(DateTime.now()),
        children: _build_group_childs(bctx, model.get_month(month)),
      );
    },
  );
}

List<Widget> _build_group_childs(BuildContext bctx, Iterable<User> users) {
  var locale_model = Provider.of<LocaleModel>(bctx);
  return users.map<ListTile>((User user) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(user.full_name),
          VerticalDivider(),
          Text(user.nickname ?? ""),
          VerticalDivider(),
          Text(
            DateFormat.yMd(
              locale_model.locale.languageCode,
            ).format(user.birthday.toLocal()),
          ),
        ],
      ),
    );
  }).toList();
}
