import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project/appcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CoinProgress extends StatelessWidget {
  final double value;
  const CoinProgress({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    double percentage = 0;

    if (value > 100) {
      percentage = 100;
    } else {
      percentage = value;
    }

    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 5.w,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
              ),
              LinearPercentIndicator()
              // Container(
              //   height: 5.w,
              //   width: 50.w,
              //   decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [
              //           AppColor.pastelBlue,
              //           AppColor.pastelBlue,
              //           AppColor.pastelBlue,
              //         ],
              //       ),
              //       borderRadius: BorderRadius.circular(20)),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
