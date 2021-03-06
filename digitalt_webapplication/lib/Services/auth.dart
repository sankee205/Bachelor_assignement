import 'package:digitalt_application/AppManagement/StorageManager.dart';
import 'package:digitalt_application/LoginRegister/locator.dart';
import 'package:digitalt_application/models/subscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/material.dart';
import 'package:digitalt_application/Services/firestoreService.dart';

///
///this class handles authentication services regarding user
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  BaseUser _currentUser;
  BaseUser get currentUser => _currentUser;

  isUserAnonymous() {
    return _auth.currentUser.isAnonymous;
  }

  //returns the user id / uid
  getUserUid() {
    return _auth.currentUser.uid;
  }

  deleteUser() async {
    User user = _auth.currentUser;
    if (user != null) {
      await user.delete();
    } else {
      print('user is null');
    }
  }

  //returns the user role
  Future<String> getUserRole() async {
    if (_auth.currentUser.isAnonymous) {
      return 'Guest';
    } else {
      var user = await getFirebaseUser();
      return user.userRole;
    }
  }

  //returns the firebase baseuser
  Future<BaseUser> getFirebaseUser() async {
    return await _firestoreService.getUser(_auth.currentUser.uid);
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
      await _populateCurrentUser(result.user);
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
          myCases: [],
          mySubscription: Subscription(
              amount: '',
              freeMonthUsed: false,
              orderId: '',
              status: 'nonActive',
              timeStamp: '',
              transactionText: '',
              expiredDate: ''));

      await _firestoreService.createUser(_currentUser);
      StorageManager.saveData('uid', authResult.user.uid);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  //checks if the user is logged inn
  Future<bool> isUserLoggedIn() async {
    var firebaseUser = _auth.currentUser;
    if (firebaseUser == null) {
      bool user;
      await StorageManager.readData('uid').then((value) async {
        print('userid');
        print(value);
        if (value != null) {
          _currentUser = await _firestoreService.getUser(value);
          user = true;
        } else {
          user = false;
        }
      });
      print(user);
      return user;
    } else {
      return await _populateCurrentUser(firebaseUser);
    }
  }

  //sets the _current user variable
  Future<bool> _populateCurrentUser(User user) async {
    if (user != null) {
      if (user.isAnonymous) {
        _currentUser = BaseUser(
            email: 'null',
            fullName: 'null',
            myCases: [],
            phonenumber: 'null',
            uid: user.uid,
            userRole: 'Guest');
        return true;
      } else {
        print('user is not anonym');
        _currentUser = await _firestoreService.getUser(user.uid);
        StorageManager.saveData('uid', user.uid);
        return true;
      }
    } else {
      return false;
    }
  }

  //signs out the user
  Future signOut() async {
    try {
      StorageManager.deleteData('uid');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
