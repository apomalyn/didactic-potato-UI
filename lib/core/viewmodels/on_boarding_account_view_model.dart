import 'package:UI/core/models/user.dart';
import 'package:flutter/material.dart';

import 'base_view_model.dart';

class OnBoardingAccountViewModel extends BaseViewModel {

  User _user;
  User get user => _user;

  OnBoardingAccountViewModel({@required User user})  {
    _user = user;
  }

  void setFirstName(String firstName) {
    user.firstname = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    user.lastname = lastName;
    notifyListeners();
  }
}