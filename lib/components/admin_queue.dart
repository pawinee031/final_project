import 'package:flutter/material.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/components/custom_button.dart';

import 'package:project/models/bookingV2.dart';
import 'package:project/providers/bookng_provider_v2.dart';
import 'package:project/screens/admin/edit/edit.dart';
import 'package:provider/provider.dart';

class QueueTile extends StatelessWidget {
  final BookingV2 booking;
  final VoidCallback? update;

  const QueueTile({super.key, required this.booking, this.update});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${booking.data?.user?.firstName} ${booking.data?.user?.lastName}'),
                  if (booking.flag != "COMPLETE" && booking.flag != "CANCELED")
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Edit(
                              bookingData: booking,
                            ),
                          ));
                        },
                        icon: Icon(Icons.edit),
                        label: Text('Edit'))
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Mobile No. : ${booking.data?.user?.mobile}'),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(child: Text('Desc. : ${booking.data?.desc}')),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(child: Text('Date. : ${booking.timeslot?.date}')),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                        child: Text('Time. : ${booking.timeslot?.timeOfDay}')),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                        child: Text('Timeslot. : ${booking.timeslot?.slot}')),
                  ],
                ),
              ),
              booking.flag != null
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(child: Text('Status. : ${booking.flag}')),
                        ],
                      ),
                    )
                  : Container(),
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      onTap: booking.active == false
                          ? null
                          : () async {
                              final provider = Provider.of<BookingProviderV2>(
                                  context,
                                  listen: false);
                              await FirestoreActions().completeBooking(
                                  booking.bookingId!, "COMPLETE", booking.uid!);

                              provider.updateBooking();
                            },
                      child: Text('Confirm'),
                    )),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, elevation: 0),
                      child: Text('Cancel'),
                      onPressed: booking.active == false
                          ? null
                          : () async {
                              final provider = Provider.of<BookingProviderV2>(
                                  context,
                                  listen: false);
                              await FirestoreActions()
                                  .cancelBooking(context, booking.bookingId!);

                              provider.updateBooking();

                              if (update != null) {
                                update!();
                              }
                            },
                    )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
