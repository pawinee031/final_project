import 'package:flutter/material.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/components/dialog/dialog_general.dart';
import 'package:project/constants.dart';
import 'package:project/models/bookingV2.dart';

import 'package:project/providers/bookng_provider_v2.dart';
import 'package:project/providers/timeslot_provider.dart';
import 'package:project/screens/timeslot/components/timeslot.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSlotView extends StatefulWidget {
  final String date;
  const TimeSlotView({super.key, required this.date});

  @override
  State<TimeSlotView> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlotView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeSlotView'),
      ),
      body: Column(
        children: [
          Flexible(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(25),
                    alignment: Alignment.centerLeft,
                    child: Text('Slot A 09:00 - 12:00')),
                Wrap(
                    children: List.generate(
                        slotCount,
                        (index) => TimeSlot(
                              blockedColor: Colors.grey[300]!,
                              baseHrs: 9,
                              slotTitle: "A${index + 1}",
                              slotTime: ((index + 1) * 15),
                            )).toList()),
                Container(
                    padding: const EdgeInsets.all(25),
                    alignment: Alignment.centerLeft,
                    child: Text('Slot B 14:00 - 16.00')),
                Wrap(
                    //ห่อ timeslot ที่วน loop กันให้เป็น box
                    children: List.generate(
                        8,
                        (index) => TimeSlot(
                              blockedColor: Colors.grey[300]!,
                              baseHrs: 14,
                              slotTitle: "B${index + 1}",
                              slotTime: ((index + 1) * 15),
                            )).toList()),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(children: [
              Row(
                children: [
                  Container(
                    color: Colors.grey[100],
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Booked'),
                ],
              ),
              Row(
                children: [
                  Container(
                    color: Colors.grey,
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Free'),
                ],
              ),
              Row(
                children: [
                  Container(
                    color: Colors.blue,
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Selected'),
                ],
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          showSelectionDialog(context,
                              title: "Booking Queue",
                              message: "Are you sure to booking this timeslot?",
                              onConfirm: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            TimeSlotProvider timeSlotProvider =
                                Provider.of<TimeSlotProvider>(context,
                                    listen: false);
                            BookingProviderV2 bookingProvider =
                                Provider.of<BookingProviderV2>(context,
                                    listen: false);

                            bookingProvider.booking.uid =
                                sharedPreferences.getString('uid');
                            bookingProvider.booking.timeslot = Timeslot(
                                date: widget.date,
                                timeOfDay: timeSlotProvider.timeOfTheDay,
                                slot: timeSlotProvider.selectedSlot);

                            FirestoreActions()
                                .createBookingRecord(bookingProvider.booking);

                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Book Now')),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
