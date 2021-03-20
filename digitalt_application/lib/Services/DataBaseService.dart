import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      String text) async {
    return await FirebaseFirestore.instance.collection('AllCases').doc(uid).set({
      'image': image,
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'introduction': introduction,
      'description': text,
    });
  }
  Future updateCaseByFolder(String folder,
      String image,
      String title,
      List<String> author,
      String publishedDate,
      String introduction,
      String text) async {
    return await FirebaseFirestore.instance.collection(folder).doc(uid).set({
      'image': image,
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'introduction': introduction,
      'description': text,
    });
  }

  Future getCaseItems(String folder) async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance.collection(folder).get().then((querySnapshot) {
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
      print(1);
      var metaData = fb.UploadMetadata(contentType: mimeType);
      print(2);
      fb.StorageReference storageReference =
          fb.storage().ref('images').child(mediaInfo.fileName);
      print(3);
      fb.UploadTaskSnapshot uploadTaskSnapshot =
          await storageReference.put(mediaInfo.data, metaData).future;
      print(4);
      Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
      print(5);
      return imageUri;
    } catch (e) {
      print('File Upload Error: $e');
      return null;
    }
  }

  Future<String> downloadUrl(String fileName) async{
    return FirebaseStorage.instance.ref('images').child(fileName).getDownloadURL();
  }

}
