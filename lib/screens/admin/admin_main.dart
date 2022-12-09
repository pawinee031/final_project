import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/actions/auth.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/components/admin_queue.dart';
import 'package:project/models/bookingV2.dart';
import 'package:project/providers/bookng_provider_v2.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  List bookList = [];
  int currentPage = 0;
  initialAction() async {
    var response = await FirestoreActions().getAllQueueAsAdmin();
    final provider = Provider.of<BookingProviderV2>(context, listen: false);

    provider.setBookingList(response);
  }

  @override
  void initState() {
    super.initState();
    initialAction();
    filterByStatusFlag();
  }

  List<BookingV2> filterByStatusFlag() {
    final provider = Provider.of<BookingProviderV2>(context, listen: false);

    if (currentPage == 1) {
      return provider.getCancelledBook();
    } else if (currentPage == 2) {
      return provider.getCompleteBook();
    } else
      return provider.getPendingBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Main'),
      ),
      body: Consumer<BookingProviderV2>(
        builder: (context, value, child) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: currentPage == 0
                                    ? Colors.blueAccent
                                    : Colors.transparent,
                                width: 4))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentPage = 0;
                          });

                          value.updateBooking();
                        },
                        child: Text('Pending')),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: currentPage == 1
                                    ? Colors.blueAccent
                                    : Colors.transparent,
                                width: 4))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentPage = 1;
                          });
                        },
                        child: Text('Cancelled')),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: currentPage == 2
                                    ? Colors.blueAccent
                                    : Colors.transparent,
                                width: 4))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            currentPage = 2;
                          });
                        },
                        child: Text('Complete')),
                  )),
                ]),
              ),
              filterByStatusFlag().length > 0
                  ? Flexible(
                      child: ListView.builder(
                      itemCount: filterByStatusFlag().length,
                      itemBuilder: (context, index) {
                        return QueueTile(
                          booking: filterByStatusFlag()[index],
                        );
                      },
                    ))
                  : Flexible(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('No Data!')],
                    )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50.w,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Auth.signout(context);
                        },
                        child: Text("Logout")),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        },
      ),
    );
  }
}
