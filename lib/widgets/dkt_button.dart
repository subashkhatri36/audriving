import 'package:flutter/material.dart';

class DktButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;

  const DktButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(text),
        ),
      ),
    );
  }
}
