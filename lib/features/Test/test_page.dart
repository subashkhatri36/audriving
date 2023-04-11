import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatefulWidget {
  final String? id;
  final String? category;
  final String lastPath;

  const TestPage({
    Key? key,
    this.id,
    this.category,
    required this.lastPath,
  }) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.go(widget.lastPath),
        ),
      ),
      body: Container(),
    );
  }
}
