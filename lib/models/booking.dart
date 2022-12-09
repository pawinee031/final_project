class Booking {
  String? bookingId;
  String? bookingDate;
  String? bookingTime;
  String? firstName;
  String? lastName;
  int? age;
  String? tel;
  String? description;
  bool? active;

  Booking({
    this.bookingId,
    this.bookingDate,
    this.bookingTime,
    this.firstName,
    this.lastName,
    this.age,
    this.tel,
    this.description,
    this.active,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    age = json['age'];
    tel = json['tel'];
    description = json['description'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['booking_date'] = this.bookingDate;
    data['booking_time'] = this.bookingTime;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['age'] = this.age;
    data['tel'] = this.tel;
    data['description'] = this.description;
    data['active'] = this.active;
    return data;
  }
}
