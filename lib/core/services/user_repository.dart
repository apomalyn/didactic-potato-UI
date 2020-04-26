// FLUTTER AND THIRD-PARTIES
import 'dart:async';
import 'package:UI/core/models/student.dart';
import 'package:UI/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// SERVICE
import 'package:UI/core/services/api.dart';

// MODELS
import 'package:UI/core/models/user.dart';

class UserRepository {
  final Api _api;
  final StorageService _storageService;

  FirebaseAuth _auth;
  GoogleSignIn _googleSignIn;

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  UserRepository({@required Api api, @required StorageService storageService})
      : _api = api,
        _storageService = storageService,
        _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  Future<bool> isSignedIn() async {
    var currentUser = await _auth.currentUser();
    if (currentUser != null) {
      _userController.add(await _fetchUserSpecificData(currentUser.uid));
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

      _userController.add(await _fetchUserSpecificData(res.user.uid, additionalUserInfo: res.additionalUserInfo));
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
      var res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _userController.add(await _fetchUserSpecificData(res.user.uid, additionalUserInfo: res.additionalUserInfo));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Register a new user
  /// @throw [ERROR_EMAIL_ALREADY_IN_USE] if the user is already register with this email
  Future<bool> registerUser(String email, String password) async {
    var res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    res.user.sendEmailVerification();

    return true;
  }

  Future<void> signout() async {
    if (await _auth.currentUser() != null) {
      await _auth.signOut();
      _userController.close();
      _userController = StreamController<User>();
    }
  }

  Future<User> _fetchUserSpecificData(String uuid, {AdditionalUserInfo additionalUserInfo}) async {
    User user = await _api.getUserInfo(uuid: uuid);
    user.pictureLink = await _storageService.getUrlLink(user.uuid);

    if(user is Student)
      user.cv = await _storageService.getUrlLink(user.uuid, isAvatar: false);

    if(additionalUserInfo != null)
      user.isNewUser = additionalUserInfo.isNewUser;

    return user;
  }
}
