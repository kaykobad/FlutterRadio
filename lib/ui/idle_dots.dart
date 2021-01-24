import 'package:flutter/material.dart';

class IdleIndicatorWidget extends StatelessWidget {
  final Color color;

  IdleIndicatorWidget({this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    final dots = List.generate(5, (_) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
          height: 10,
          width: 10,
        ),
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }
}