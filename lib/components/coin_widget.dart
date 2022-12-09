import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/appcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinWidget extends StatefulWidget {
  final int point;
  const CoinWidget({super.key, required this.point});

  @override
  State<CoinWidget> createState() => _CoinWidgetState();
}

class _CoinWidgetState extends State<CoinWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          constraints: BoxConstraints(minWidth: 25.w),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 57, 104, 157),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${widget.point}',
                style: TextStyle(color: AppColor.white),
              ),
              Icon(
                Ionicons.logo_bitcoin,
                color: AppColor.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
