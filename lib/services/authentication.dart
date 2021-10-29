import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;

  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> googleSignIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount!.authentication;

      final AuthCredential cred = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      UserCredential res = await _auth.signInWithCredential(cred);
      User? user = res.user;

      if (user != null) {
        updateUserData(user);
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> anonLogIn() async {
    UserCredential res = await _auth.signInAnonymously();
    User? user = res.user;

    if (user != null) {
      updateUserData(user);
      return user;
    } else {
      return null;
    }
  }

  Future<void> updateUserData(User user) {
    DocumentReference reportRef = _db.collection('reports').doc(user.uid);

    return reportRef.set({
      'uid': user.uid,
      'lastActivity': DateTime.now(),
    }, SetOptions(merge: true));
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
