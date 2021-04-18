import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalt_application/models/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future createUser(BaseUser user) async {
    try {
      await _usersCollectionReference.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      dynamic userData = await _usersCollectionReference.doc(uid).get();
      BaseUser user = BaseUser.fromData(userData.data());
      return user;
    } catch (e) {
      return e.message;
    }
  }
}
