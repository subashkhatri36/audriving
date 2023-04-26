import 'package:flutter/material.dart';

class FadeTransactionWidget extends StatefulWidget {
  const FadeTransactionWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final child;

  @override
  FadeTransactionState createState() => FadeTransactionState();
}

class FadeTransactionState extends State<FadeTransactionWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      } else if (status == AnimationStatus.dismissed) {
        _controller.stop();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}
