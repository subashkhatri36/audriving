import 'package:flutter/cupertino.dart';

class DktSpace extends StatelessWidget {
  final double height;

  const DktSpace({
    Key? key,
    this.height = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
