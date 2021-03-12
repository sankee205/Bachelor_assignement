import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:path/path.dart' as Path;

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users'); //What to collect
  final CollectionReference caseCollection =
      FirebaseFirestore.instance.collection('CaseItems');

  Future updateUserData(String name, String email, String phonenumber) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    });
  }

  Future updateCaseData(
      String image,
      String title,
      List<String> author,
      String publishedDate,
      String introduction,
      List<String> description) async {
    return await caseCollection.doc(uid).set({
      'image': image,
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'introduction': introduction,
      'description': description,
    });
  }

  Future getCaseItems() async {
    List itemsList = [];
    try {
      await caseCollection.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Uri> uploadFile(MediaInfo mediaInfo) async {
    try {
      String mimeType = mime(Path.basename(mediaInfo.fileName));
      var metaData = fb.UploadMetadata(contentType: mimeType);
      fb.StorageReference storageReference =
          fb.storage().ref('images').child(mediaInfo.fileName);

      fb.UploadTaskSnapshot uploadTaskSnapshot =
          await storageReference.put(mediaInfo.data, metaData).future;
      Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
      return imageUri;
    } catch (e) {
      print('File Upload Error: $e');
      return null;
    }
  }
}
