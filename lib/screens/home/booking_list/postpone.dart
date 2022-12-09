import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/components/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class PostPoneDialog extends StatefulWidget {
  final String booking_id;
  final String booking_time;
  final String booking_date;
  const PostPoneDialog(
      {super.key,
      required this.booking_id,
      required this.booking_time,
      required this.booking_date});

  @override
  State<PostPoneDialog> createState() => _PostPoneDialogState();
}

class _PostPoneDialogState extends State<PostPoneDialog> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;

  late String currentTime;

  @override
  void initState() {
    currentTime = widget.booking_time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 70.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'เลื่อนนัด',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.25),
                  ),
                ),
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  weekNumbersVisible: false,
                  daysOfWeekVisible: false,
                  dayHitTestBehavior: HitTestBehavior.translucent,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {},
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'เวลา',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: CustomButton(
                    child: Text(currentTime),
                    onTap: () async {
                      TimeOfDay currentBookingTime =
                          TimeOfDay(hour: 0, minute: 0);
                      String hrs =
                          widget.booking_time.split(" ").first.split(":").first;
                      String min =
                          widget.booking_time.split(" ").first.split(":").last;
                      if (widget.booking_time.split(" ").last == "AM") {
                        currentBookingTime = TimeOfDay(
                            hour: int.parse(hrs), minute: int.parse(min));
                      }
                      if (widget.booking_time.split(" ").last == "PM") {
                        currentBookingTime = TimeOfDay(
                            hour: int.parse(hrs) + 12, minute: int.parse(min));
                      }
                      final res = await showTimePicker(
                          context: context, initialTime: currentBookingTime);

                      setState(() {
                        _selectedTime = res;
                        currentTime = _selectedTime!.format(context);
                      });
                    },
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: CustomButton(
                          child: Text('Confirm'),
                          onTap: _selectedDay != null || _selectedTime != null
                              ? () async {
                                  print(widget.booking_id);
                                  final String date = _selectedDay!
                                      .toIso8601String()
                                      .split("T")
                                      .first;
                                  if (_selectedTime == null) {
                                    await FirestoreActions().postponeBooking(
                                      context,
                                      widget.booking_id,
                                      date,
                                    );
                                  } else {
                                    await FirestoreActions().postponeBooking(
                                        context, widget.booking_id, date,
                                        booking_time:
                                            _selectedTime!.format(context));
                                  }
                                  Navigator.pop(context);
                                }
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: CustomButton(
                          child: Text('Cancel'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showPostponeDialog(
  BuildContext context, {
  required String bookingId,
  required String bookingDate,
  required String bookingTime,
}) async {
  showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: true,
    pageBuilder: (context, _, __) {
      return PostPoneDialog(
        booking_id: bookingId,
        booking_date: bookingDate,
        booking_time: bookingTime,
      );
    },
  );
}
