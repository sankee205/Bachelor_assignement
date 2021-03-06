import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalt_application/models/subscription.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:path/path.dart' as Path;

/// this is the dabate service. it handles data
/// requests, posts and updates to the database
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users'); //What to collect

  //-----------------user related methods---------------------------------------
  Future updateUserData(
      String id, String name, String email, String phonenumber) async {
    return await _userCollection.doc(id).update({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    });
  }

  Future updateMyCasesData(String id, List myCases) async {
    return await _userCollection.doc(id).update({'myCases': myCases});
  }

  Future setUserRole(String id, String role) async {
    if (role != 'Admin') {
      return await _userCollection.doc(id).update({'userRole': role});
    } else {
      return null;
    }
  }

  Future deleteUser(String id) async {
    return await _userCollection.doc(id).delete();
  }

  //------------------case item methods-----------------------------------------
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

  Future addCaseItem(String image, String title, List author,
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

  Future getCaseItems(String folder) async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection(folder)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          //print(element.id);
          if (!element.data().containsKey('id')) {
            element.reference.update({'id': element.id});
          }
          itemsList.add(element);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //---------------------------info page methods--------------------------------
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

  //--------------------------Terms methods--------------------------------------
  Future updateGdprContent(String text, String date) async {
    return await FirebaseFirestore.instance
        .collection('GDPR')
        .doc('GGR6mGOSrcVFjhug1gpi')
        .set({
      'text': text,
      'date': date,
    });
  }

  Future getGdprContent() async {
    List infoList = [];
    await FirebaseFirestore.instance.collection('GDPR').get().then((value) => {
          value.docs.forEach((element) {
            infoList.add(element);
          })
        });
    return infoList;
  }

  Future updateUserTermsContent(String text, String date) async {
    return await FirebaseFirestore.instance
        .collection('UserTerms')
        .doc('rEjKUjviUjXpVCme4ljJ')
        .set({
      'text': text,
      'date': date,
    });
  }

  Future getUserTermsContent() async {
    List infoList = [];
    await FirebaseFirestore.instance
        .collection('UserTerms')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                infoList.add(element);
              })
            });
    return infoList;
  }

  //--------------------------folder methods------------------------------------

  Future updateCaseByFolder(
      String folder,
      String image,
      String title,
      List author,
      String publishedDate,
      String introduction,
      List text,
      String lastEdited) async {
    return await FirebaseFirestore.instance.collection(folder).doc(uid).set({
      'image': image,
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'introduction': introduction,
      'text': text,
      'lastEdited': lastEdited
    });
  }

  Future updateCaseItemByFolder(
    String folder,
    String id,
    String image,
    String title,
    List author,
    String lastEdited,
    String introduction,
    List text,
  ) async {
    return await FirebaseFirestore.instance.collection(folder).doc(id).update({
      'image': image,
      'title': title,
      'author': author,
      'lastEdited': lastEdited,
      'introduction': introduction,
      'text': text,
    });
  }

  Future updateFolder(String folder, List<Map<String, dynamic>> newList) async {
    await FirebaseFirestore.instance.collection(folder).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    for (int i = 0; i < newList.length; i++) {
      Map<String, dynamic> item = newList[i];
      updateCaseByFolder(
          folder,
          item['image'],
          item['title'],
          item['author'],
          item['publishedDate'],
          item['introduction'],
          item['text'],
          item['lastEdited']);
    }
  }

//---------------------------Guest list methods---------------------------------
  Future updateGuestList(List<Map<String, dynamic>> newList) async {
    await FirebaseFirestore.instance
        .collection('GuestList')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    for (int i = 0; i < newList.length; i++) {
      Map<String, dynamic> item = newList[i];
      await FirebaseFirestore.instance
          .collection('GuestList')
          .doc(uid)
          .set({'Title': item['Title']});
    }
  }

  Future getGuestListContent() async {
    List guestList = [];
    await FirebaseFirestore.instance
        .collection('GuestList')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                guestList.add(element);
              })
            });
    return guestList;
  }

  //-------------------------------Image methods--------------------------------
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

  //------------------------------Subscription Methods--------------------------
  Future updateSubscriptionData(String id, Subscription mySubscription) async {
    return await _userCollection.doc(id).update({
      'mySubscription': mySubscription.toJson(),
    });
  }

  //------------------------------VippsPrices-------------------------------------
  Future getVippsPricesContent() async {
    List vippsList = [];
    await FirebaseFirestore.instance
        .collection('VippsPrices')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                vippsList.add(element);
              })
            });
    return vippsList;
  }
}
