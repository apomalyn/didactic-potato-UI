// FLUTTER AND THIRD-PARTIES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// VIEWMODEL AND MODEL
import 'package:UI/core/viewmodels/sign_in_view_model.dart';

// OTHER
import 'package:UI/ui/utils/theme.dart' as AppColor;
import 'package:UI/ui/views/base_widget.dart';
import 'package:UI/core/constants/router_paths.dart';
import 'package:toast/toast.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _confirmPassword;

  bool _isRegistering = false;

  bool _enableBtn = false;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SignInViewModel>(
        model: SignInViewModel(authenticationService: Provider.of(context)),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(size: 512),
                elevation: 0,
              ),
              body: Center(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: model.busy
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.sandy),
                              ),
                              SizedBox(height: 75),
                              _isRegistering
                                  ? _buildRegisterForm(model)
                                  : _buildSignInForm(model),
                              SizedBox(height: 30),
                              _buildSignInWithButton('Google', () async {
                                var loginSuccess =
                                    await model.signInWithGoogle();
                                if (loginSuccess) {
                                  Navigator.pushNamed(
                                      context, RouterPaths.HOME);
                                }
                              }),
                              SizedBox(height: 10),
                              _buildSignInWithButton('Github', () async {
                                var loginSuccess =
                                    await model.signInWithGithub();
                                if (loginSuccess) {
                                  Navigator.pushNamed(
                                      context, RouterPaths.HOME);
                                }
                              })
                            ],
                          ),
                  ),
                ),
              ),
            ));
  }

  Widget _buildSignInWithButton(String company, Function callback) {
    return RaisedButton.icon(
      onPressed: callback,
      icon: ImageIcon(
          AssetImage('assets/images/${company.toLowerCase()}_logo.png')),
      label: Text("Sign in with $company"),
      color: Colors.white,
      padding: EdgeInsets.all(10),
      elevation: 5,
    );
  }

  Widget _buildSignInForm(SignInViewModel model) {
    return Form(
      key: _formKey,
      onChanged: () =>
          setState(() => _enableBtn = _formKey.currentState.validate()),
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
              onSaved: (value) => _email = value,
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              validator: _validatePassword,
              onSaved: (value) => _password = value,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  child: Text('Sign In'),
                  color: AppColor.persian,
                  onPressed: _enableBtn
                      ? () async {
                          var loginSuccess =
                              await model.signInWithEmail(_email, _password);
                          if (loginSuccess) {
                            Navigator.pushNamed(context, RouterPaths.HOME);
                          }
                        }
                      : null,
                  elevation: 5,
                ),
                SizedBox(width: 20),
                RaisedButton(
                  child: Text('Register'),
                  color: AppColor.persian,
                  elevation: 5,
                  onPressed: () => setState(() {
                    _isRegistering = true;
                  }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm(SignInViewModel model) {
    return Form(
      key: _formKey,
      onChanged: () =>
          setState(() => _enableBtn = _formKey.currentState.validate()),
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
              onSaved: (value) => _email = value,
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              validator: _validatePassword,
              onSaved: (value) => _password = value,
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm your password',
              ),
              validator: _validateConfirmPassword,
              onSaved: (value) => _confirmPassword = value,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  child: Text('Sign in'),
                  color: AppColor.persian,
                  elevation: 5,
                  onPressed: () => setState(() {
                    _isRegistering = false;
                  }),
                ),
                SizedBox(width: 20),
                RaisedButton(
                    child: Text('Register'),
                    color: AppColor.persian,
                    elevation: 5,
                    onPressed: _enableBtn
                        ? () async {
                            var registerSucceed =
                                await model.register(_email, _password);
                            if(registerSucceed) {}
                            else {
                              setState(() {
                                _isRegistering = false;
                              });
                              Toast.show("Email already used", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                            }
                          }
                        : null)
              ],
            )
          ],
        ),
      ),
    );
  }

  String _validateEmail(String value) {
    RegExp regExp =
        RegExp(r'([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})');

    if (value.length == 0)
      return 'Please enter your email.';
    else if (!regExp.hasMatch(value)) return 'Please enter a valid email.';
    _formKey.currentState.save();
    return null;
  }

  String _validatePassword(String value) {
    if (value.length == 0) return 'Please enter your password.';
    return null;
  }

  String _validateConfirmPassword(String value) {
    if(value.length == 0 && _password.length == 0) return null;
    if(value != _password) return 'Please enter the same password';
    return null;
  }
}
