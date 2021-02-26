import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users'); //What to collect
  final CollectionReference caseCollection =
      FirebaseFirestore.instance.collection('Cases');
  final CollectionReference authorCollection =
      FirebaseFirestore.instance.collection('Authors');

  Future updateUserData(String name, String email, String phonenumber) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    });
  }

  Future updateCaseData(String title, String image, String date, String author,
      String text) async {
    return await caseCollection.doc(uid).set({
      'title': title,
      'image': image,
      'date': date,
      'author': author,
      'text': text,
    });
  }

  Future updateAuthorData(String name, String email, String phonenumber) async {
    return await authorCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    });
  }
}
