import 'package:UI/core/constants/router_paths.dart';
import 'package:UI/core/models/user.dart';
import 'package:UI/core/viewmodels/on_boarding_account_view_model.dart';
import 'package:UI/ui/views/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:UI/ui/utils/theme.dart' as AppColor;
import 'package:provider/provider.dart';

class OnBoardingAccountView extends StatefulWidget {

  UserType _userType;

  OnBoardingAccountView(UserType type) {
    _userType = type;
  }

  @override
  _OnBoardingAccountViewState createState() => _OnBoardingAccountViewState(_userType);
}

class _OnBoardingAccountViewState extends State<OnBoardingAccountView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();

  UserType _userType;

  _OnBoardingAccountViewState(UserType type) {
    _userType = type;
  }

  String _validateNames(String value) => value == null || value.isEmpty ? "Please enter a value." : null;

  @override
  Widget build(BuildContext context) {
    // Ideally a Stepper should be there, but lack of time made that it cannot be done. 😅
    return BaseWidget<OnBoardingAccountViewModel>(
      model: OnBoardingAccountViewModel(
          user: Provider.of<User>(context)),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Form(
              key: _formKey,
              child: Center(
                child: Card(
                  child: Container(
                    width: 600,
                    height: 300,
                    child: Column(
                      children: <Widget>[
                        Row(
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
                            SizedBox(height: 15.0),
                          ],
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 48.0, top: 32.0),
                                  child: Container(
                                    width: 200,
                                    child: TextFormField(
                                      controller: _firstNameController,
                                      validator: (value) => _validateNames(value),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'First Name',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.0, top: 32.0),
                                  child: Container(
                                    width: 200,
                                    child: TextFormField(
                                      controller: _lastNameController,
                                      validator: (value) => _validateNames(value),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Last Name',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 52.0, right: 16.0),
                            child: MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  model.setFirstName(_firstNameController.text);
                                  model.setLastName(_lastNameController.text);
                                  Navigator.pushNamed(context, RouterPaths.ON_BOARDING_TAGS, arguments: _userType);
                                }
                              },
                              color: AppColor.persian,
                              child: Text(
                                "Next Step",
                                style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}