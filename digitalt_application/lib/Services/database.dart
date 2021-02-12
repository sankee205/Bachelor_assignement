import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('Users'); //What to collect
  final CollectionReference caseCollection =
      Firestore.instance.collection('Cases');
  final CollectionReference authorCollection =
      Firestore.instance.collection('Authors');

  Future updateUserData(String name, String email, String phonenumber) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    });
  }

  Future updateCaseData(String title, String image, String date, String author,
      String text) async {
    return await caseCollection.document(uid).setData({
      'title': title,
      'image': image,
      'date': date,
      'author': author,
      'text': text,
    });
  }

  Future updateAuthorData(String name, String email, String phonenumber) async {
    return await authorCollection.document(uid).setData({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    });
  }
}
