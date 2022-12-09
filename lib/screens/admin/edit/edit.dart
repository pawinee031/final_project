import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/components/confirmation_dialog.dart';

import 'package:project/models/bookingV2.dart';
import 'package:project/providers/bookng_provider_v2.dart';
import 'package:project/providers/timeslot_provider.dart';
import 'package:project/screens/timeslot/components/timeslot.dart';
import 'package:project/utils/utils.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  final BookingV2 bookingData;
  const Edit({super.key, required this.bookingData});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  getBlockedTimeSlot({String? timeFormatted}) async {
    final TimeSlotProvider timeSlotProvider =
        Provider.of<TimeSlotProvider>(context, listen: false);
    List<String> blockedSlot = await FirestoreActions().getBlockedTimeSlot(
        date: timeFormatted ?? widget.bookingData.timeslot!.date!);
    timeSlotProvider.setBlockedSlot(blockedSlot);
  }

  initialAction() async {
    getBlockedTimeSlot();
  }

  TextEditingController _telController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _descriptionC0ntroller = TextEditingController();

  var before = {
    "slot": "",
    "date": "",
    "time": "",
  };
  var after = {
    "slot": "-",
    "date": "",
    "time": "-",
  };

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.bookingData.data?.user?.firstName ?? "";
    _lastNameController.text = widget.bookingData.data?.user?.lastName ?? "";
    before['slot'] = widget.bookingData.timeslot!.slot!;
    before['date'] = widget.bookingData.timeslot!.date!;
    before['time'] = widget.bookingData.timeslot!.timeOfDay!;
    after['date'] = widget.bookingData.timeslot!.date!;
    initialAction();
  }

  getDisplayDate() {
    if (after["date"] == "" || after["date"] == null) {
      return before["date"];
    } else {
      return after["date"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Consumer<TimeSlotProvider>(builder: (context, timeslotPvd, child) {
        return Column(
          children: [
            // Text(widget.bookingData.bookingId.toString()),
            Flexible(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: TextFormField(
                            controller: _firstNameController,
                            enabled: false,
                          )),
                          Container(
                            color: Colors.transparent,
                            width: 20,
                          ),
                          Flexible(
                              child: TextFormField(
                            controller: _lastNameController,
                            enabled: false,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(children: [
                    Expanded(child: Text("Booking Date")),
                    ElevatedButton(
                      child: Text(after['date'].toString()),
                      onPressed: () async {
                        final TimeSlotProvider timeSlotProvider =
                            Provider.of<TimeSlotProvider>(context,
                                listen: false);
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(
                                widget.bookingData.timeslot!.date!),
                            firstDate: DateTime.parse(
                                widget.bookingData.timeslot!.date!),
                            lastDate: DateTime.now().add(Duration(days: 30)));
                        if (newDate != null) {
                          setState(() {
                            after['date'] =
                                newDate.toIso8601String().split("T").first;
                            after['slot'] = timeSlotProvider.selectedSlot;
                            after['time'] = timeSlotProvider.timeOfTheDay;
                          });
                          getBlockedTimeSlot(
                              timeFormatted:
                                  newDate.toIso8601String().split("T").first);
                        }
                      },
                    )
                  ]),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Selected Time :  ${timeslotPvd.timeOfTheDay} - ${Utils.addMin(timeslotPvd.timeOfTheDay)}"),
                      ),
                      Container(
                          padding: const EdgeInsets.all(25),
                          alignment: Alignment.centerLeft,
                          child: Text('Slot A 09:00 - 12:00  ')),
                      Wrap(
                          children: List.generate(
                              12,
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
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text("Save Changes"),
                        onPressed: after["slot"] == "" && after["date"] == ""
                            ? null
                            : () {
                                showGeneralDialog(
                                  context: context,
                                  pageBuilder: (context, animation, _) {
                                    return ConfirmationDialog(
                                      title: "Confirmed Changes?",
                                      onConfirm: () async {
                                        if (after["slot"] == "-" ||
                                            after["time"] == "-") {
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(SnackBar(
                                          //         backgroundColor: Colors.red,
                                          //         content: Text(
                                          //             'Failed to Changes Queue detail')));

                                          Fluttertoast.showToast(
                                              msg:
                                                  "Failed to Changes Queue detail",
                                              backgroundColor: Colors.red);

                                          // Navigator.pop(context);
                                        } else {
                                          final bool res =
                                              await FirestoreActions()
                                                  .updateQueue(
                                            bookingId:
                                                widget.bookingData.bookingId ??
                                                    "",
                                            newDate: after["date"] ??
                                                widget.bookingData.timeslot!
                                                    .date!,
                                            newSlot: after["slot"] ?? "-",
                                            newTime: after["time"] ?? "-",
                                          );

                                          if (res) {
                                            final BookingProviderV2 provider =
                                                Provider.of<BookingProviderV2>(
                                                    context,
                                                    listen: false);
                                            provider.updateBooking();
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }
                                        }
                                      },
                                      description: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Before",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Text("Slot : ${before['slot']}"),
                                          Text("Date : ${before['date']}"),
                                          Text("Time : ${before['time']}"),
                                          Row(
                                            children: [
                                              Text(
                                                "After",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Text("Slot : ${after['slot']}"),
                                          Text("Date : ${after['date']}"),
                                          Text("Time : ${after['time']}"),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
