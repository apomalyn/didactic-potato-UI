import 'package:flutter/material.dart';

class AccountAvatar extends StatelessWidget {
  final String _uri;

  AccountAvatar({String uri}) : _uri = uri;

  @override
  Widget build(BuildContext context) {
    if (_uri == null) {
      return CircleAvatar(
        backgroundColor: Colors.red,
        child: Text("You"),
      );
    }
    return CircleAvatar(
      radius: 48.0,
      backgroundImage: NetworkImage(_uri),
    );
  }
}
