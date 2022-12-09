import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  const SquareButton({
    super.key,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
