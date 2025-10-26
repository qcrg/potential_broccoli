import 'package:flutter/material.dart';
import 'package:potential_broccoli/l10n/app_localizations.dart';

enum Entryes {
  export_,
  import_;

  String title(AppLocalizations l) {
    return switch (this) {
      Entryes.export_ => l.export,
      Entryes.import_ => l.import,
    };
  }

  IconData icon() {
    return switch (this) {
      Entryes.export_ => Icons.upload,
      Entryes.import_ => Icons.download,
    };
  }

  static List<PopupMenuEntry<int>> gen_for_popup(AppLocalizations l) {
    return List<PopupMenuEntry<int>>.generate(Entryes.values.length, (int i) {
      final entry = Entryes.values[i];
      return PopupMenuItem<int>(
        value: i,
        child: ListTile(
          leading: Icon(entry.icon()),
          title: Text("${entry.title(l)}..."),
          mouseCursor: SystemMouseCursors.click,
        ),
      );
    });
  }
}
