import 'package:flutter/material.dart';

class GroupName extends StatelessWidget {
  final String title;
  final bool selected;

  const GroupName(this.title, {super.key, this.selected = false});

  @override
  Widget build(BuildContext bctx) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      selected: selected,
    );
  }
}
