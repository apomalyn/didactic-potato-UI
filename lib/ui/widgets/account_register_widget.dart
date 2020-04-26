import 'package:flutter/material.dart';

class AccountRegisterForm extends StatefulWidget {
  @override
  _AccountRegisterFormState createState() => _AccountRegisterFormState();
}

class _AccountRegisterFormState extends State<AccountRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstName;
  String _lastName;

  String _validateNames(String value) => value.isEmpty ? "Please enter a value." : null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Card(
          child: Container(
            width: 700,
            height: 500,
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 48.0, top: 32.0),
                    child: Text(
                      "Nice to meet you!",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }



}

