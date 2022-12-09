import 'package:flutter/material.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/models/booking.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> bookingList = [];

  Future<void> updateBookingList() async {
    print('Update');
    final res = await FirestoreActions().getAllBooking();

    notifyListeners();
  }

  BookingProvider();
}
