/// FLUTTER
import 'package:flutter/material.dart';

/// COLORS
import 'package:UI/ui/utils/theme.dart' as AppColor;


class SignInView extends StatelessWidget {
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
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.sandy),
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

  Widget _buildButton(String title) {
    return RaisedButton(
      color: AppColor.persian,
      onPressed: () {},
      child: Text(title),
    );
  }

  Widget _buildSignInWithButton(String company) {
    return RaisedButton.icon(
        onPressed: () {},
        icon: ImageIcon(
            AssetImage('assets/images/${company.toLowerCase()}_logo.png')),
        label: Text("Sign in with $company"),
        color: Colors.white);
  }
}
