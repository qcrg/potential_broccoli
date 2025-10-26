import 'package:flutter/material.dart';
import 'package:potential_broccoli/routes.dart';

class FAButton extends StatelessWidget {
  const FAButton({super.key});

  @override
  Widget build(BuildContext bctx) {
    return FloatingActionButton.small(
      child: Icon(Icons.add_outlined),
      onPressed: () {
        Navigator.of(bctx).pushNamed(Routes.add_user.route());
      },
    );
  }
}
