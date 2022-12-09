import 'package:uuid/uuid.dart';

class BookingV2 {
  String? bookingId;
  String? uid;
  bool? active;
  Data? data;
  Timeslot? timeslot;
  String? flag;

  BookingV2(
      {this.bookingId,
      this.uid,
      this.active,
      this.data,
      this.timeslot,
      this.flag});

  BookingV2.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    uid = json['uid'];
    active = json['active'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    timeslot = json['timeslot'] != null
        ? new Timeslot.fromJson(json['timeslot'])
        : null;
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['booking_id'] = Uuid().v4();
    data['uid'] = this.uid;
    data['active'] = this.active;
    data['flag'] = this.flag;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.timeslot != null) {
      data['timeslot'] = this.timeslot!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? desc;

  Data({this.user, this.desc});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['desc'] = this.desc;
    return data;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? age;
  String? mobile;

  User({this.firstName, this.lastName, this.age, this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    data['mobile'] = this.mobile;
    return data;
  }
}

class Timeslot {
  String? date;
  String? timeOfDay;
  String? slot;

  Timeslot({this.date, this.timeOfDay, this.slot});

  Timeslot.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timeOfDay = json['timeOfDay'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timeOfDay'] = this.timeOfDay;
    data['slot'] = this.slot;
    return data;
  }
}
