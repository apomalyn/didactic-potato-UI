/// FLUTTER
import 'package:flutter/material.dart';

class TimeSlot {
  /// When the slot start
  DateTime date;

  /// For how many time
  int duration = 15;

  TimeSlot({@required this.date, this.duration});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      date: DateTime.parse(json['date']),
      duration: json['duration']
    );
  }
}