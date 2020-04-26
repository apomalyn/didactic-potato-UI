/// FLUTTER
import 'package:flutter/material.dart';

/// MODELS
import 'package:UI/core/models/appointment.dart';
import 'package:UI/core/models/tag.dart';
import 'package:UI/core/models/time_slot.dart';
import 'package:UI/core/models/user.dart';

enum JobType { Internship, PartTime, FullTime }

class Student extends User {
  String cv;

  /// Is the student is searching a job or not
  bool isAvailable;

  /// List of skill of the student
  List<Tag> tags;

  /// What the student is searching for
  JobType searchingFor;

  Student(
      {@required uuid,
      @required firstname,
      @required lastname,
      @required email,
      @required pictureLink,
      @required availabilities,
      @required appointments,
      @required this.cv,
      @required this.isAvailable,
      @required this.tags,
      @required this.searchingFor})
      : super(
            uuid: uuid,
            firstname: firstname,
            lastname: lastname,
            email: email,
            pictureLink: pictureLink,
            availabilities: availabilities,
            appointments: appointments);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        uuid: json['uuid'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email'],
        pictureLink: json['pictureLink'],
        availabilities: (json['availabilities'] as List)
            .map((i) => TimeSlot.fromJson(i))
            .toList(),
        appointments: (json['appointments'] as List)
            .map((i) => Appointment.fromJson(i))
            .toList(),
        cv: json['cv'],
        isAvailable: json['isAvailable'],
        tags: (json['tags'] as List).map((i) => Tag.fromJson(i)).toList(),
        searchingFor: json['jobType'] == 'INTERNSHIP'
            ? JobType.Internship
            : json['jobType'] == 'PART_TIME'
                ? JobType.PartTime
                : JobType.FullTime);
  }
}
