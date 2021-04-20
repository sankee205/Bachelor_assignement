import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalt_application/Pages/ProfilePage.dart';
import 'package:digitalt_application/Pages/SingleCasePage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/firestoreService.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'BaseCaseBox.dart';

///
///this is the carousel slider used in
///the home page to display the most popular cases
///
class BaseCarouselSlider extends StatefulWidget {
  //list of cass it gets from the database
  final List caseList;

  const BaseCarouselSlider(this.caseList);

  @override
  _BaseCarouselSliderState createState() => _BaseCarouselSliderState();
}

class _BaseCarouselSliderState extends State<BaseCarouselSlider> {
  String currentUserRole;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  final DatabaseService db = DatabaseService();

  List<String> guestList = [];

  getUserRole() async {
    if (_firebaseAuth.currentUser.isAnonymous) {
      currentUserRole = 'Guest';
    } else {
      User firebaseUser = _firebaseAuth.currentUser;
      firestoreService.getUser(firebaseUser.uid).then((value) {
        setState(() {
          BaseUser user = value;
          currentUserRole = user.userRole;
        });
      });
    }
  }

  getGuestList() async {
    List<String> firebaseList = [];
    List resultant = await db.getGuestListContent();
    if (resultant != null) {
      for (int i = 0; i < resultant.length; i++) {
        var object = resultant[i];
        firebaseList.add(object['Title'].toString());
      }
      setState(() {
        guestList = firebaseList;
      });
      print(guestList);
    } else {
      print('resultant is null');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserRole();
    getGuestList();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 300,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          aspectRatio: 0.25,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayInterval: Duration(seconds: 10),
          viewportFraction: 0.8,
          initialPage: 0),
      items: widget.caseList.map((caseObject) {
        return Builder(builder: (
          BuildContext context,
        ) {
          //makes the onclick available
          return GestureDetector(
              onTap: () {
                switch (currentUserRole) {
                  case 'Admin':
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CasePage(
                                    image: caseObject['image'],
                                    title: caseObject['title'],
                                    author: caseObject['author'],
                                    publishedDate: caseObject['publishedDate'],
                                    introduction: caseObject['introduction'],
                                    text: caseObject['text'],
                                    lastEdited: caseObject['lastEdited'],
                                  )));
                    }
                    break;
                  case 'User':
                    {
                      if (guestList.contains(caseObject['title'])) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CasePage(
                                      image: caseObject['image'],
                                      title: caseObject['title'],
                                      author: caseObject['author'],
                                      publishedDate:
                                          caseObject['publishedDate'],
                                      introduction: caseObject['introduction'],
                                      text: caseObject['text'],
                                      lastEdited: caseObject['lastEdited'],
                                    )));
                      }
                    }
                    break;
                  case 'Subscriber':
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CasePage(
                                    image: caseObject['image'],
                                    title: caseObject['title'],
                                    author: caseObject['author'],
                                    publishedDate: caseObject['publishedDate'],
                                    introduction: caseObject['introduction'],
                                    text: caseObject['text'],
                                    lastEdited: caseObject['lastEdited'],
                                  )));
                    }
                    break;
                  case 'Guest':
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    }
                    break;
                }
              },
              child: BaseCaseBox(
                  image: caseObject['image'], title: caseObject['title']));
        });
      }).toList(),
    );
  }
}
