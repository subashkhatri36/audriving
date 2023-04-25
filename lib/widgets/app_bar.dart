import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar appBarBackButton(
    BuildContext context, String category, String lastPath) {
  return AppBar(
    backgroundColor: Colors.blue.shade800,
    title: Text(category ?? ''),
    leading: BackButton(
      onPressed: () {
        GoRouter.of(context).go(lastPath);
      },
    ),
  );
}
