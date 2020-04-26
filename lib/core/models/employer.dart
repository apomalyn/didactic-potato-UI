/// FLUTTER
import 'package:flutter/material.dart';

/// MODELS
import 'package:UI/core/models/student.dart';
import 'package:UI/core/models/user.dart';
import 'package:UI/core/models/appointment.dart';
import 'package:UI/core/models/time_slot.dart';

class Employer extends User {
  /// List of student "favs" by the employer
  List<Student> favoris;

  Employer(
      {@required uuid,
      @required firstname,
      @required lastname,
      @required email,
      @required availabilities,
      @required appointments,
      this.favoris})
      : super(
            uuid: uuid,
            firstname: firstname,
            lastname: lastname,
            email: email,
            availabilities: availabilities,
            appointments: appointments);


  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      uuid: json['uuid'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      availabilities: (json['availabilities'] as List).map((i) => TimeSlot.fromJson(i)).toList(),
      appointments: (json['appointments'] as List).map((i) => Appointment.fromJson(i)).toList(),
      favoris: (json['favoris'] as List).map((i) => Student.fromJson(i)).toList()
    );
  }
}
