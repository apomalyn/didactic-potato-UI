
import 'package:UI/core/services/authentication_service.dart';
import 'package:UI/core/viewmodels/base_view_model.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends BaseViewModel {
  AuthenticationService _authenticationService;

  SignInViewModel({@required AuthenticationService authenticationService}) {
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
    // TODO var success = await _authenticationService.signInWithGoogle();
    setBusy(false);

    return false;
  }
}