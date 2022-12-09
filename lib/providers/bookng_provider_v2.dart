import 'package:flutter/material.dart';
import 'package:project/actions/firestore_actions.dart';
import 'package:project/models/booking.dart';

import 'package:project/models/bookingV2.dart';

class BookingProviderV2 extends ChangeNotifier {
  List<BookingV2> bookingList = [];
  BookingV2 booking = BookingV2();

  clearBooking() {
    booking = BookingV2();
    notifyListeners();
  }

  setBookingList(List<BookingV2> bookingLists) {
    bookingList = bookingLists;
    notifyListeners();
  }

  updateBooking() async {
    final response = await FirestoreActions().getAllQueueAsAdmin();
    bookingList = response;
    notifyListeners();
  }

  List<BookingV2> getCompleteBook() {
    return bookingList.where((element) => element.flag == "COMPLETE").toList();
  }

  List<BookingV2> getCancelledBook() {
    return bookingList.where((element) => element.flag == "CANCELED").toList();
  }

  List<BookingV2> getPendingBook() {
    return bookingList.where((element) => element.flag == "PENDING").toList();
  }

  BookingProviderV2();
}
