import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// gets a user object based on firebase user
  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          _firestore.collection('users').doc(user.uid).set({
            'name': user.displayName,
            'email': user.email,
            'profile_picture': user.photoURL,
            'bio': '',
            'timestamp': DateTime.now(),
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!.toString());
      res = false;
    }
    return res;
  }

  Future<bool> signUpWithEmail({
    required BuildContext context,
    required String name,
    required String userEmail,
    required String userPassword,
  }) async {
    userEmail.trim();
    userPassword.trim();
    name.trim();
    bool res = false;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          _firestore.collection('users').doc(user.uid).set({
            'name': name,
            'email': userEmail,
            'profile_picture': '',
            'bio': '',
            'timestamp': DateTime.now(),
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
      } else {
        showSnackBar(context, e.message!.toString());
      }
      res = false;
    }
    return res;
  }

  Future<bool> signInWithEmail(
      BuildContext context, String userEmail, String userPassword) async {
    userEmail.trim();
    userPassword.trim();
    bool res = false;
    try {
      await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      res = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided');
      } else {
        showSnackBar(context, e.message!.toString());
      }
      res = false;
    }
    return res;
  }

  void signOut() {
    try {
      _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
