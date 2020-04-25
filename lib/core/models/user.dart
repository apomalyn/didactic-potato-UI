/// FLUTTER
import 'package:flutter/material.dart';

/// MODELS
import 'package:UI/core/models/time_slot.dart';
import 'package:UI/core/models/appointment.dart';

class User {
  final String uuid;

  String firstname;

  String lastname;

  String email;

  String pictureLink;

  List<TimeSlot> availabilities;

  List<Appointment> appointments;

  User({@required this.uuid, @required this.firstname, @required this.lastname, @required this.email, @required this.pictureLink,
    @required this.availabilities, @required this.appointments});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      pictureLink: json['pictureLink'],
      availabilities: json['availabilities'].map((i) => TimeSlot.fromJson(i)).toList(),
      appointments: json['appointments'].map((i) => Appointment.fromJson(i)).toList(),
    );
  }


}