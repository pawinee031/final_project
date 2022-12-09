import 'package:flutter/material.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/models/booking.dart';
import 'package:project/models/bookingV2.dart';
import 'package:project/screens/book/components/queue_detail.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<BookingV2> booking_queues = [];
  getHistory() async {
    final res = await FirestoreActions().getAllBooking(history: true);
    setState(() {
      booking_queues = res;
    });
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: booking_queues.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QueueDetail(queue: booking_queues[index]),
                          ));
                    },
                    child: Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        booking_queues[index].timeslot?.slot ??
                                            "")),
                                Text(
                                    booking_queues[index].timeslot?.timeOfDay ??
                                        ""),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        '${booking_queues[index].data?.user?.firstName ?? ""}')),
                                Text(
                                    booking_queues[index].timeslot?.date ?? ""),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // ListView(
              //   children: [Text(booking_queues.toString())],
              // ),
            )
          ],
        ),
      ),
    );
  }
}
