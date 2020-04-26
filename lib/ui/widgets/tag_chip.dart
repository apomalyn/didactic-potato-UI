// FLUTTER
import 'package:flutter/material.dart';

// MODEL
import 'package:UI/core/models/tag.dart';

class TagChip extends StatelessWidget {
  final Function onDeleted;

  final Tag tag;

  TagChip({@required this.tag, @required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(tag.name),
      deleteIcon: Icon(Icons.close),
      onDeleted: onDeleted,
      onPressed: onDeleted,
    );
  }
}