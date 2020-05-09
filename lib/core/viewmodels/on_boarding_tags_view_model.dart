import 'package:UI/core/models/student.dart';
import 'package:UI/core/models/tag.dart';
import 'package:UI/core/models/user.dart';
import 'package:flutter/material.dart';

import 'base_view_model.dart';

class OnBoardingTagsViewModel extends BaseViewModel {

  User _user;
  User get user => _user;

  OnBoardingTagsViewModel({@required User user})  {
    _user = user;
  }

  void handleDeletionTag(Tag toRemove) {
    (user as Student).tags.remove(toRemove);
    notifyListeners();
  }

  void handleAddTag(Tag value) {
    if(!(_user as Student).tags.contains(value)){
      (_user as Student).tags.add(value);
      notifyListeners();
    }
  }

  List<Tag> getTags() {
    return (_user as Student).tags;
  }
}