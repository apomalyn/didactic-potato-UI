// FLUTTER
import 'dart:html';

import 'package:UI/core/models/student.dart';
import 'package:UI/core/models/tag.dart';
import 'package:UI/core/services/storage_service.dart';
import 'package:flutter/material.dart';

// SERVICES
import 'package:UI/core/services/api.dart';

// MODELS
import 'package:UI/core/models/user.dart';

// OTHER
import 'package:UI/core/viewmodels/base_view_model.dart';

class AccountViewModel extends BaseViewModel {
  Api _api;
  StorageService _storageService;

  Student _user;
  Student get user => _user;

  bool _isModified = false;
  bool get isModified => _isModified;

  AccountViewModel({@required Api api, @required StorageService storageService, @required User user})  {
    _api = api;
    _storageService = storageService;
    _user = user as Student;
  }

  /// Update the type of job
  /// @param [JobType] new value
  /// WARNING DON'T UPDATE THE USER ON THE DATABASE
  void handleSearchingForChange(JobType type) {
    _user.searchingFor = type;
    _isModified = true;
    notifyListeners();
  }

  /// Remove a tag from the user
  /// @param [Tag] tag to remove
  /// WARNING DON'T UPDATE THE USER ON THE DATABASE
  void handleDeletionTag(Tag toRemove) {
    _isModified = true;
    _user.tags.remove(toRemove);
    notifyListeners();
  }

  /// Add a tag to the user, only if not already on it
  /// @param [Tag] tag to add
  /// WARNING DON'T UPDATE THE USER ON THE DATABASE
  void handleAddTag(Tag value) {
    if(!_user.tags.contains(value)){
      _user.tags.add(value);
      _isModified = true;
      notifyListeners();
    }
  }

  /// Save the changes done by the user
  /// @return bool - true if the save succeed
  Future<bool> save() async {
    setBusy(true);
    bool success = await _api.addStudent(user: _user);
    _isModified = false;
    setBusy(false);

    return success;
  }

  /// Call the service to upload a file to Firebase
  /// @param file to upload
  /// @return bool true if the upload succeed
  Future<bool> uploadToFirebase(File file) async {
    setBusy(true);
    bool success = await _storageService.uploadFile(file, filename: "${_user.uuid}.${file.type.split('/').last}");
    setBusy(false);

    return success;
  }

  List<Tag> getTags() {
    return _user.tags;
  }

  Future<String> getAccountImage() async {
    return await _storageService.getUrlLink(_user.uuid);
  }
}