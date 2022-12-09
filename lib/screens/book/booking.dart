import 'package:flutter/material.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/models/bookingV2.dart';
import 'package:project/screens/book/book_form.dart';
import 'package:project/screens/book/components/queue_detail.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<BookingV2> booking_queues = [];
  loadBookingQueue() async {
    final res = await FirestoreActions().getAllBooking();
    setState(() {
      booking_queues = res;
    });
  }

  @override
  void initState() {
    loadBookingQueue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Card(
        color: Colors.grey[100],
        margin: const EdgeInsets.all(0),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: booking_queues.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  QueueDetail(queue: booking_queues[index]),
                            ));
                        loadBookingQueue();
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
                                      child: Text(booking_queues[index]
                                              .timeslot
                                              ?.slot ??
                                          "")),
                                  Text(booking_queues[index]
                                          .timeslot
                                          ?.timeOfDay ??
                                      ""),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          '${booking_queues[index].data?.user?.firstName ?? ""}')),
                                  Text(booking_queues[index].timeslot?.date ??
                                      ""),
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
              ),
              Container(
                child: SizedBox(
                  width: 50.w,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookForm(),
                            ));
                        loadBookingQueue();
                      },
                      child: Text('New Booking')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
