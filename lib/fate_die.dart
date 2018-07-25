import 'package:flutter/material.dart';

class FateDie extends StatelessWidget {
  FateDie({
    Key key,
    this.size = 56.0,
    this.value,
  }) : super(key: key) {
    assert(value >= -1 && value <= 1);
  }

  final double size;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.25),
        color: Colors.black87,
      ),
      child: value != 0
          ? Icon(
              value > 0 ? Icons.add : Icons.remove,
              color: Colors.white,
              size: size * 0.8,
            )
          : null,
    );
  }
}
