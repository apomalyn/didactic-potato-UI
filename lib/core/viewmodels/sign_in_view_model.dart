// FLUTTER
import 'package:flutter/material.dart';

// SERVICE
import 'package:UI/core/services/user_repository.dart';

// OTHER
import 'package:UI/core/viewmodels/base_view_model.dart';


class SignInViewModel extends BaseViewModel {
  UserRepository _userRepository;

  SignInViewModel({@required UserRepository authenticationService}) {
    _userRepository = authenticationService;
  }

  /// Try to sign in the user using a Google account
  Future<bool> signInWithGoogle() async {
    setBusy(true);
    var success = await _userRepository.signInWithGoogle();
    setBusy(false);

    return success;
  }

  /// Try to sign in the user using a Github account
  Future<bool> signInWithGithub() async {
    setBusy(true);
    // TODO var success = await _authenticationService.signInWithGithub();
    setBusy(false);

    return false;
  }

  /// Try to sign in the user using a email/password
  Future<bool> signInWithEmail(String email, String password) async {
    setBusy(true);
    var success = await _userRepository.signInWithEmail(email, password);
    setBusy(false);

    return success;
  }

  Future<bool> register(String email, String password) async {
    setBusy(true);
    try {
      var success = await _userRepository.registerUser(email, password);
      setBusy(false);
    } catch (e) {
      print(e.code);
      if(e.code == "auth/email-already-in-use") {
        setBusy(false);
        return false;
      }
    }
  }
}