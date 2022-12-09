import 'package:flutter/material.dart';

import 'package:project/providers/timeslot_provider.dart';
import 'package:project/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TimeSlot extends StatelessWidget {
  final String slotTitle;
  final int slotTime;
  final int baseHrs;
  final Color inactiveColor;
  final Color activeColor;
  final Color blockedColor;
  final bool active;
  const TimeSlot({
    super.key,
    this.baseHrs = 9,
    this.slotTitle = "A1",
    this.slotTime = 0,
    this.inactiveColor = Colors.grey,
    this.activeColor = Colors.blue,
    this.blockedColor = Colors.red,
    this.active = false,
  });

  setSlotColor(TimeSlotProvider timeSlotProvider) {
    if (timeSlotProvider.blockedSlot.contains(slotTitle))
      return blockedColor;
    else if (timeSlotProvider.selectedSlot == slotTitle)
      return activeColor;
    else
      return inactiveColor;
  }

  @override
  Widget build(BuildContext context) {
    List<int> convertMinToHrs(min) {
      if (min % 60 == 0) {
        return [
          min ~/ 60,
          min % 60,
        ];
      } else {
        return [
          min ~/ 60,
          min % 60,
        ];
      }
    }

    return Container(
      width: 25.w, // 25% ของความกว้างเอามาจาก libary
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Consumer<TimeSlotProvider>(
            builder: (context, TimeSlotProvider timeSlotProvider, _) {
          return GestureDetector(
            onTap: timeSlotProvider.blockedSlot.contains(slotTitle)
                ? null
                : () {
                    timeSlotProvider.setSelectedSlot(slotTitle);
                    timeSlotProvider.setTimeOfTheDay(
                        "${baseHrs + convertMinToHrs(slotTime)[0]}:${convertMinToHrs(slotTime)[1].toString().padLeft(2, '0')} ");
                  },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(2),
              color: setSlotColor(timeSlotProvider),
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(slotTitle),
                  Text(
                    "${baseHrs + convertMinToHrs(slotTime)[0]}:${convertMinToHrs(slotTime)[1].toString().padLeft(2, '0')} - ${Utils.addMin("${baseHrs + convertMinToHrs(slotTime)[0]}:${convertMinToHrs(slotTime)[1].toString().padLeft(2, '0')}")}",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
