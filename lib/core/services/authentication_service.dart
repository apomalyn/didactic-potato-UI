import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  FirebaseAuth _auth;
  GoogleSignIn _googleSignIn;

  StreamController<FirebaseUser> _userController =
      StreamController<FirebaseUser>();

  Stream<FirebaseUser> get user => _userController.stream;

  AuthenticationService()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

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

      _userController.add(res.user);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    if (await _auth.currentUser() != null) {
      await _auth.signOut();
      _userController.close();
      _userController = StreamController<FirebaseUser>();
    }
  }
}
