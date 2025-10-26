import 'package:flutter/material.dart';
import 'package:potential_broccoli/constants.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';
import 'package:potential_broccoli/l10n/utils.dart';
import 'package:potential_broccoli/models.dart';
import 'package:potential_broccoli/routes.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LeftMenu extends StatefulWidget {
  const LeftMenu({super.key});

  @override
  State<LeftMenu> createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  final _ctrl = ItemScrollController();

  @override
  Widget build(BuildContext bctx) {
    var l = AppLocalizations.of(bctx)!;
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Container()),
          Expanded(
            child: Consumer<MonthSelectionModel>(
              builder: (_, MonthSelectionModel model, _) {
                return ScrollablePositionedList.builder(
                  itemCount: Months.values.length,
                  initialScrollIndex: model.month.index,
                  itemBuilder: _item_builder,
                  itemScrollController: _ctrl,
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(l.settings),
            onTap: () {
              Navigator.of(bctx)
                ..pop()
                ..pushNamed(Routes.settings.route());
            },
          ),
        ],
      ),
    );
  }
}

Widget _item_builder(BuildContext _, int i) {
  final month = Months.fromInt(i);
  return Consumer<MonthSelectionModel>(
    builder: (bctx, model, _) {
      var l = AppLocalizations.of(bctx)!;
      return ListTile(
        title: Text(month.translate(l)),
        selected: month == model.month,
        onTap: () {
          Navigator.of(bctx).pop();
          model.month = month;
        },
      );
    },
  );
}
