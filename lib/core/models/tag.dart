import 'package:flutter/material.dart';

/// Tag to identify a skill, technology, framework, ...
class Tag{
  final String name;

  final String description;

  Tag({@required this.name, this.description});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(name: json['name'], description: json['description']);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Tag &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;
}
