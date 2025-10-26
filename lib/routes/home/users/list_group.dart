import 'package:flutter/material.dart';
import 'package:potential_broccoli/routes/home/users/group_name.dart';

class ListGroup extends StatelessWidget {
  final List<Widget> children;
  final Widget? placeholder;
  final bool selected;
  final String title;

  const ListGroup({
    super.key,
    required this.title,
    this.children = const <Widget>[],
    this.placeholder,
    this.selected = false,
  });

  @override
  Widget build(BuildContext bctx) {
    var childs = <Widget>[GroupName(title, selected: selected), ...children];
    if (children.isEmpty && placeholder != null) {
      childs.add(placeholder!);
    }
    return Column(children: childs);
  }
}
