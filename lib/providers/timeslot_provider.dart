import 'dart:developer';

import 'package:flutter/material.dart';

class TimeSlotProvider extends ChangeNotifier {
  List<String> blockedSlot = [];
  String selectedSlot = "";

  String timeOfTheDay = "";
  TimeSlotProvider();

  setSelectedSlot(String slotTitle) {
    print(slotTitle);
    selectedSlot = slotTitle;
    notifyListeners();
  }

  setTimeOfTheDay(String time) {
    print("time of day $time");
    this.timeOfTheDay = time;
    notifyListeners();
  }

  setBlockedSlot(List<String> blockedSlot) {
    this.blockedSlot = blockedSlot;
    notifyListeners();
  }
}
