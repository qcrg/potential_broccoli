import 'package:flutter/material.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';
import 'package:potential_broccoli/routes/home/popup_menu/entry.dart';
import 'package:potential_broccoli/routes/home/users.dart';
import 'package:potential_broccoli/routes/home/fa_button.dart';
import 'package:potential_broccoli/routes/home/leftmenu.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext bctx) {
    var l = AppLocalizations.of(bctx)!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (int val) {},
            itemBuilder: (BuildContext bctx) {
              return Entryes.gen_for_popup(AppLocalizations.of(bctx)!);
            },
          ),
        ],
        title: Text(l.app_title),
      ),
      drawer: LeftMenu(),
      body: Users(),
      floatingActionButton: FAButton(),
    );
  }
}
