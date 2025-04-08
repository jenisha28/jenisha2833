import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_app/main.dart';

class FirebaseAuthService {
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebase
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
    return null;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebase.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await firebase.signOut();
    } on Exception catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }
}
