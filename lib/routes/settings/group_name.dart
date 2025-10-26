import 'package:flutter/material.dart';

class GroupName extends StatelessWidget {
  final String title;

  const GroupName(this.title, {super.key});

  @override
  Widget build(BuildContext bctx) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
