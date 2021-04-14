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

  Future updateCaseItemData(String id, String image, String title, List author,
      String publishedDate, String introduction, List text) async {
    return await FirebaseFirestore.instance
        .collection('AllCases')
        .doc(id)
        .update({
      'image': image,
      'title': title,
      'author': author,
      'lastEdited': publishedDate,
      'introduction': introduction,
      'text': text,
    });
  }

  Future updateCaseData(String image, String title, List author,
      String publishedDate, String introduction, List text) async {
    return await FirebaseFirestore.instance
        .collection('AllCases')
        .doc(uid)
        .set({
      'image': image,
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'lastEdited': null,
      'introduction': introduction,
      'text': text,
    });
  }

  Future updateInfoPageContent(
      String textPhoto,
      String contactPhoto,
      String email,
      String tlf,
      List text,
      List author,
      String date,
      String backgroundPhoto) async {
    return await FirebaseFirestore.instance
        .collection('InfoPageContent')
        .doc('bsvyKpuVnZBhQ8ydA161')
        .set({
      'textPhoto': textPhoto,
      'contactPhoto': contactPhoto,
      'backgroundPhoto': backgroundPhoto,
      'text': text,
      'author': author,
      'date': date,
      'email': email,
      'tlf': tlf,
    });
  }

  Future getInfoPageContent() async {
    List infoList = [];
    await FirebaseFirestore.instance
        .collection('InfoPageContent')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                infoList.add(element);
              })
            });
    return infoList;
  }

  Future getSingleCaseItem(String title) async {
    List resultList = [];
    await FirebaseFirestore.instance
        .collection('AllCases')
        .where('title', isEqualTo: title)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                resultList.add(element);
              })
            });
    return resultList;
  }

  Future updateCaseByFolder(String folder, String image, String title,
      List author, String publishedDate, String introduction, List text) async {
    return await FirebaseFirestore.instance.collection(folder).doc(uid).set({
      'image': image,
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'introduction': introduction,
      'text': text,
      'lastEdited': null
    });
  }

  Future updateFolder(String folder, Map<String, dynamic> newCases) async {
    return await FirebaseFirestore.instance
        .collection(folder)
        .doc(uid)
        .set(newCases);
  }

  Future getCaseItems(String folder) async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection(folder)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          //print(element.id);
          //element.reference.update({'id':element.id});
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

  Future<String> downloadUrl(String fileName) async {
    return FirebaseStorage.instance
        .ref('images')
        .child(fileName)
        .getDownloadURL();
  }
}
