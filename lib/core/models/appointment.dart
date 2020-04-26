import 'dart:convert';

/// FLUTTER
import 'package:flutter/material.dart';

/// MODELS
import 'package:UI/core/models/time_slot.dart';

/// Model of a meeting scheduled between an student and an employer
class Appointment {
  TimeSlot timeSlot;

  /// UUID of the student
  String student;

  /// UUID of the employer
  String employer;

  /// Url of the meeting
  String meetingUrl;

  Appointment({@required this.timeSlot, @required this.student, @required this.employer, @required this.meetingUrl});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      timeSlot: TimeSlot.fromJson(json['timeSlot']),
      student: json['studentuuid'],
      employer: json['employeruuid'],
      meetingUrl: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'timeSlot': jsonEncode(timeSlot),
    'studentuuid': student,
    'employeruuid': employer,
    'url': meetingUrl,
  };
}