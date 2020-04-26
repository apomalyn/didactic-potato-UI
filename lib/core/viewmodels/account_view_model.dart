// FLUTTER
import 'package:UI/core/models/student.dart';
import 'package:UI/core/models/tag.dart';
import 'package:flutter/material.dart';

// SERVICES
import 'package:UI/core/services/api.dart';

// MODELS
import 'package:UI/core/models/user.dart';

// OTHER
import 'package:UI/core/viewmodels/base_view_model.dart';

class AccountViewModel extends BaseViewModel {
  Api _api;

  User _user;
  User get user => _user;

  AccountViewModel({@required Api api, @required User user})  {
    _api = api;
    _user = user;
  }

  /// Update the type of job
  void handleSearchingForChange(JobType type) {
    (user as Student).searchingFor = type;
    notifyListeners();
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