import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  const CustomButton({super.key, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: child,
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
      ),
    );
  }
}
