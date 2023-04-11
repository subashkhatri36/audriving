import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget appBarBackButton(
    BuildContext context, String category, String lastPath) {
  return AppBar(
    title: Text(category ?? ''),
    leading: BackButton(
      onPressed: () {
        GoRouter.of(context).go(lastPath);
      },
    ),
  );
}
