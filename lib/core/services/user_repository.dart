// FLUTTER AND THIRD-PARTIES
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// SERVICE
import 'package:UI/core/services/api.dart';

// MODELS
import 'package:UI/core/models/user.dart';

class UserRepository {
  final Api _api;
  FirebaseAuth _auth;
  GoogleSignIn _googleSignIn;

  StreamController<User> _userController =
      StreamController<User>();

  Stream<User> get user => _userController.stream;

  UserRepository({@required Api api})
      : _api = api,
        _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  Future<bool> isSignedIn() async {
    var currentUser = await _auth.currentUser();
    if(currentUser != null) {
      User fetchedUserInfo = await _api.getUserInfo(uuid: currentUser.uid);

      _userController.add(fetchedUserInfo);
      return true;
    }
    return false;
  }

  /// Sign in with the Google Account
  /// @return true if the login succeed
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var res = await _auth.signInWithCredential(credential);

      User fetchedUserInfo = await _api.getUserInfo(uuid: res.user.uid);
      fetchedUserInfo.isNewUser = res.additionalUserInfo.isNewUser;

      _userController.add(fetchedUserInfo);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Sign in with the email/password
  /// @return true if the login succeed.
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      var res = await _auth.signInWithEmailAndPassword(email: email, password: password);

      User fetchedUserInfo = await _api.getUserInfo(uuid: res.user.uid);

      fetchedUserInfo.isNewUser = res.additionalUserInfo.isNewUser;

      _userController.add(fetchedUserInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Register a new user
  /// @throw [ERROR_EMAIL_ALREADY_IN_USE] if the user is already register with this email
  Future<bool> registerUser(String email, String password) async {
    var res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    res.user.sendEmailVerification();

    return true;
  }

  Future<void> logout() async {
    if (await _auth.currentUser() != null) {
      await _auth.signOut();
      _userController.close();
      _userController = StreamController<User>();
    }
  }
}
