/// FLUTTER
import 'package:flutter/material.dart';

/// COLORS
import 'package:UI/ui/utils/theme.dart' as AppColor;

class SignInView extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(size: 512),
        elevation: 0,
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.sandy),
                ),
                SizedBox(height: 75),
                Form(
                  key: _formKey,
                  onChanged: () => setState(
                      () => _enableBtn = _formKey.currentState.validate()),
                  child: Container(
                    width: 400,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: _validateEmail,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: _validatePassword,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Sign In'),
                              color: AppColor.persian,
                              onPressed: _enableBtn ? () {} : null,
                              elevation: 5,
                            ),
                            SizedBox(width: 20),
                            RaisedButton(
                              child: Text('Register'),
                              color: AppColor.persian,
                              elevation: 5,
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                _buildSignInWithButton('Google'),
                SizedBox(height: 10),
                _buildSignInWithButton('Github')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithButton(String company) {
    return RaisedButton.icon(
        onPressed: () {},
        icon: ImageIcon(
            AssetImage('assets/images/${company.toLowerCase()}_logo.png')),
        label: Text("Sign in with $company"),
        color: Colors.white,
      padding: EdgeInsets.all(10),
      elevation: 5,
    );
  }

  String _validateEmail(String value) {
    RegExp regExp =
        RegExp(r'([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})');

    if (value.length == 0)
      return 'Please enter your email.';
    else if (!regExp.hasMatch(value)) return 'Please enter a valid email.';
    return null;
  }

  String _validatePassword(String value) {
    if (value.length == 0) return 'Please enter your password.';
    return null;
  }
}
