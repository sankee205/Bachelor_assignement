import 'package:digitalt_application/LoginRegister/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/material.dart';
import 'package:digitalt_application/Services/firestoreService.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  BaseUser _currentUser;
  BaseUser get currentUser => _currentUser;

  //create user object based on FirebaseUser
  BaseUser _userFromFirebaseUser(User user) {
    return user != null ? BaseUser(uid: user.uid) : null;
  }

  getUser() {
    return _auth.currentUser.uid;
  }

  getFirebaseUser() async {
    return await _firestoreService.getUser(_auth.currentUser.uid);
  }

  //auth change user stream
  Stream<BaseUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      await _populateCurrentUser(result.user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //await _populateCurrentUser(result.user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String phonenumber,
    @required String role,
  }) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = BaseUser(
          uid: authResult.user.uid,
          email: email,
          fullName: fullName,
          phonenumber: phonenumber,
          userRole: role,
          myCases: []);

      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    _auth.authStateChanges().listen((User user) {});
    var firebaseUser = _auth.currentUser;
    return await _populateCurrentUser(firebaseUser);
  }

  Future<bool> _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
      return true;
    } else {
      return false;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
