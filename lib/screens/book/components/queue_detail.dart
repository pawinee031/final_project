import 'package:flutter/material.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../models/bookingV2.dart';

class QueueDetail extends StatelessWidget {
  final BookingV2? queue;

  const QueueDetail({super.key, this.queue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Queue Details')),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Text('Name'),
              ),
              Text(
                  "${queue?.data?.user?.firstName ?? ""} ${queue?.data?.user?.lastName ?? ""}"),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Age'),
              ),
              Text("${queue?.data?.user?.age ?? ""}"),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Desc'),
              ),
              Text("${queue?.data?.desc ?? ""}"),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Slot'),
              ),
              Text("${queue?.timeslot?.slot ?? ""}"),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Time'),
              ),
              Text("${queue?.timeslot?.timeOfDay ?? ""}"),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('Date'),
              ),
              Text("${queue?.timeslot?.date ?? ""}"),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 50.w,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[800], elevation: 0),
                onPressed: queue?.active == false
                    ? null
                    : () async {
                        await FirestoreActions()
                            .cancelBooking(context, queue!.bookingId!);
                        Navigator.pop(context);
                      },
                child: Text('Cancel')),
          )
        ]),
      ),
    );
  }
}
