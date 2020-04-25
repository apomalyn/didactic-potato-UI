import 'package:flutter/material.dart';

/// Tag to identify a skill, technology, framework, ...
class Tag {
  final String name;

  final String description;

  Tag({@required this.name, @required this.description});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(name: json['name'], description: json['description']);
  }
}
