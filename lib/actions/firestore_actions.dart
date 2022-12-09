import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/providers/booking_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/bookingV2.dart';

class FirestoreActions {
  final int givingPoint = 100;
  late FirebaseFirestore firestore;

  FirestoreActions() {
    firestore = FirebaseFirestore.instance;
  }

  Future<Map<String, dynamic>> getUserProfile(String uid) async {
    Query query = firestore.collection("app_user").where("uid", isEqualTo: uid);
    QuerySnapshot querySnapshot = await query.get();
    var user = querySnapshot.docs.first.data() as Map;

    print(user);
    return {
      "uid": user['uid'],
      "email": user['email'],
      "first_name": user['first_name'],
      "last_name": user['last_name'],
      "role": user['role'] == null ? 0 : 1, // 0 = normal user 1 = admin
      "birthdate": user['birthdate'],
      "age": user['age'],
      "mobileNo": user['mobileNo'],
    };
  }

  createUser(Map user) async {
    return firestore
        .collection("app_user")
        .add({
          "uid": user['uid'],
          "token": user['token'],
          "email": user['email'],
          "first_name": user['first_name'],
          "last_name": user['last_name'],
          "reward_point": 0,
          "age": user['age'],
          "birthdate": user['birthdate'],
          "mobileNo": user['mobileNo'],
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  createBookingRecord(BookingV2 booking) async {
    //post booking
    final SharedPreferences sp = await SharedPreferences.getInstance();

    print(booking.toJson());

    EasyLoading.show(status: "Booking...");
    var body = booking.toJson();

    body["flag"] = "PENDING";
    return firestore //save collection
        .collection('booking_queue')
        .add(body) //แปลงเป็น Json
        .then(
      (_) {
        EasyLoading.dismiss();
        return true;
      },
    ).whenComplete(
      () {
        EasyLoading.dismiss();
        return true;
      },
    ).catchError(
      (_) {
        EasyLoading.dismiss();
        return false;
      },
    );
  }

  Future<List<BookingV2>> getAllBooking({bool history = false}) async {
    //pull all booking
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid')!;
    final Query query = firestore
        .collection('booking_queue')
        .where('uid', isEqualTo: uid)
        .where('active', isEqualTo: !history);
    final QuerySnapshot querySnapshot = await query.get();

    final List response =
        querySnapshot.docs.map((e) => e.data()).toList(); //เป็น list

    print(response);
    return response
        .map((e) => BookingV2.fromJson(e))
        .toList(); // convert json to list
  }

  Future<void> cancelBooking(BuildContext context, String bookingId) async {
    try {
      EasyLoading.show(status: "กำลังยกเลิก");
      print(bookingId);
      final SharedPreferences sp = await SharedPreferences.getInstance();

      final Query query = await firestore //หา book id เหมือนกัน
          .collection('booking_queue')
          .where("booking_id", isEqualTo: bookingId); //ได้ตำแหน่งมา

      query.get().then((QuerySnapshot snapshot) async {
        //วนหา query
        await firestore
            .collection('booking_queue')
            .doc(snapshot.docs.first.id) //snapshot -> data firestore
            .update({
          "active": false,
          "flag": "CANCELED"
        }); // update is false -> if cancel
      });
      // final provider = Provider.of<BookingProvider>(context, listen: false);
      await Future.delayed(Duration(milliseconds: 500));
      // provider.updateBookingList();
      EasyLoading.dismiss();
      print('done');
    } catch (err) {
      print(err);
    }
  }

  Future<void> postponeBooking(
      // เลื่อนนัด
      BuildContext context,
      String bookingId,
      String booking_date,
      {String? booking_time}) async {
    Map<String, Object> body = {};
    try {
      EasyLoading.show(status: "กำลังดำเนินการ");

      if (booking_time != null) {
        body = {"booking_date": booking_date, "booking_time": booking_time};
      } else {
        body = {"booking_date": booking_date};
      }
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String accessToken = sp.getString('accessToken')!;

      final Query query = await firestore
          .collection('userdata')
          .doc(accessToken)
          .collection('booking')
          .where("booking_id", isEqualTo: bookingId);

      query.get().then((QuerySnapshot snapshot) async {
        await firestore
            .collection('userdata')
            .doc(accessToken)
            .collection('booking')
            .doc(snapshot.docs.first.id)
            .update(body);
      });
      final provider = Provider.of<BookingProvider>(context, listen: false);
      await Future.delayed(Duration(milliseconds: 500));
      provider.updateBookingList(); //save in provider
      EasyLoading.dismiss();
      print('update done');
    } catch (err) {
      print(err);
    }
  }

  Future<List<String>> getBlockedTimeSlot({String date = ""}) async {
    print('date $date');
    Query query = firestore
        .collection('booking_queue')
        .where('timeslot.date', isEqualTo: date)
        // edit
        // add pending
        // .where('active', isEqualTo: false)
        // .where(
        //   'flag',
        //   isEqualTo: "COMPLETE",
        // )
        .where('flag', whereIn: ["PENDING", "COMPLETE", "CANCELED"]);
    // .where(
    //   'flag',
    //   isEqualTo: "CANCELED",
    // );

    QuerySnapshot querySnapshot = await query.get();

    List<String> blockedSlots = querySnapshot.docs
        .map((e) => (e.data() as Map)['timeslot']['slot'].toString())
        .toList();

    return blockedSlots;
  }

  getAllQueueAsAdmin() async {
    //pull all booking
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Query query = firestore.collection('booking_queue');
    final QuerySnapshot querySnapshot = await query.get();
    final List response =
        querySnapshot.docs.map((e) => e.data()).toList(); //เป็น list

    return response
        .map((e) => BookingV2.fromJson(e))
        .toList(); // convert json to list
  }

  completeBooking(String bookingId, String flagName, String uid) async {
    try {
      final rewardQuery = await firestore
          .collection('app_user')
          .where('uid', isEqualTo: uid)
          .get();

      int rp = rewardQuery.docs.first.data()['reward_point'];

      print(rp);
      EasyLoading.show(status: "กำลังดำเนินการ");
      print(bookingId);

      final Query query = await firestore //หา book id เหมือนกัน
          .collection('booking_queue')
          .where("booking_id", isEqualTo: bookingId); //ได้ตำแหน่งมา
      query.get().then((QuerySnapshot snapshot) async {
        //วนหา query
        await firestore
            .collection('booking_queue')
            .doc(snapshot.docs.first.id) //snapshot -> data firestore
            .update({
          "active": false,
          "flag": "$flagName"
        }); // update is false -> if cancel
      });
      // final provider = Provider.of<BookingProvider>(context, listen: false);

      print("order uid $uid");
      QuerySnapshot userQuery = await firestore
          .collection('app_user')
          .where('uid', isEqualTo: uid)
          .get();
      print('userQuery.docs.first.id ${userQuery.docs.first.id}');
      await firestore.collection('app_user').doc(userQuery.docs.first.id)
          // reward point
          .update({"reward_point": rp + givingPoint});

      await Future.delayed(Duration(milliseconds: 500));
      // provider.updateBookingList();
      EasyLoading.dismiss();
      print('done');
    } catch (err) {
      print(err);
      EasyLoading.dismiss();
    }
  }

  Future<int> getReward(String uid) async {
    final rewardQuery = await firestore
        .collection('app_user')
        .where('uid', isEqualTo: uid)
        .get();

    int rp = rewardQuery.docs.first.data()['reward_point'];
    return rp;
  }

  Future<bool> exchangeReward({required int pointToDeduct}) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String uid = sp.getString('uid') ?? "";
    try {
      EasyLoading.show(status: 'Loading');
      final rewardQuery = await firestore
          .collection('app_user')
          .where('uid', isEqualTo: uid)
          .get();
      int rp = rewardQuery.docs.first.data()['reward_point'];

      if (rp < pointToDeduct) {
        // แต้มพอ ?
        throw Exception('not enough point');
      } else {
        QuerySnapshot userQuery = await firestore
            .collection('app_user')
            .where('uid', isEqualTo: uid)
            .get();
        print('userQuery.docs.first.id ${userQuery.docs.first.id}');
        await firestore.collection('app_user').doc(userQuery.docs.first.id)
            // reward point
            .update({"reward_point": rp - pointToDeduct});

        print('success');
        EasyLoading.dismiss();

        return true;
      }
    } catch (err) {
      EasyLoading.dismiss();
      print(err);
      return false;
    }
  }

  // update time and slot
  Future<bool> updateQueue({
    required String bookingId,
    required String newTime,
    required String newSlot,
    required String newDate,
  }) async {
    try {
      EasyLoading.show(status: "Updating");
      final Query query = await FirebaseFirestore.instance
          .collection("/booking_queue")
          .where('booking_id', isEqualTo: bookingId);

      final QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.length > 0) {
        final String docId = snapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection("/booking_queue")
            .doc(docId)
            .update({
          "timeslot.slot": newSlot,
          "timeslot.timeOfDay": newTime,
          "timeslot.date": newDate,
        });
        EasyLoading.dismiss();
        return true;
      } else {
        throw Exception('Exception : Not Found');
      }
    } catch (err) {
      print(err);
      EasyLoading.dismiss();
      return false;
    }

    // final resQuery = await res.get();
    // print(resQuery.docs.length);
  }
}
