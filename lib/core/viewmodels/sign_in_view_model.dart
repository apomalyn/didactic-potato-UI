// FLUTTER
import 'package:flutter/material.dart';

// SERVICE
import 'package:UI/core/services/user_repository.dart';

// OTHER
import 'package:UI/core/viewmodels/base_view_model.dart';


class SignInViewModel extends BaseViewModel {
  UserRepository _authenticationService;

  SignInViewModel({@required UserRepository authenticationService}) {
    _authenticationService = authenticationService;
  }

  /// Try to sign in the user using a Google account
  Future<bool> signInWithGoogle() async {
    setBusy(true);
    var success = await _authenticationService.signInWithGoogle();
    setBusy(false);

    return success;
  }

  /// Try to sign in the user using a Github account
  Future<bool> signInWithGithub() async {
    setBusy(true);
    // TODO var success = await _authenticationService.signInWithGoogle();
    setBusy(false);

    return false;
  }

  /// Try to sign in the user using a email/password
  Future<bool> signInWithEmail(String email, String password) async {
    setBusy(true);
    var success = await _authenticationService.signInWithEmail(email, password);
    setBusy(false);

    return success;
  }
}