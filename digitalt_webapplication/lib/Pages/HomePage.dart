import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Layouts/BaseCarouselSlider.dart';
import 'package:digitalt_application/Layouts/BaseCaseBox.dart';
import 'package:digitalt_application/Pages/ProfilePage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Pages/SingleCasePage.dart';
import 'package:digitalt_application/Services/firestoreService.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:digitalt_application/Services/auth.dart';

/*
 * This is the main page of the flutter application and this is the window that will
 * open when you open the app. At the top it has an appbar with a drawer, then below 
 * the appbar a slider for newest/top X images, and at the end a gridview for all 
 * images in the list of items; _listItem.
 * 
 * @Sander Keedklang
 * 
 */

//creates a stateful widget
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

// this class represents a home page with a grid layout
class HomePageState extends State<HomePage> {
  //example list for the grid layout
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService firestoreService = FirestoreService();
  final AuthService _auth = AuthService();
  final DatabaseService db = DatabaseService();
  List newCases = [];
  List allCases = [];
  List popularCases = [];

  String currentUserRole;
  List<String> guestList = [];

  @override
  void initState() {
    super.initState();
    //db.updateCaseData('image', 'title', ['author'], 'publishedDate', 'introduction', 'text');
    //db.updateCaseByFolder('PopularCases','image', 'title', ['author'], 'publishedDate', 'introduction', 'text');
    //db.updateCaseByFolder('NewCases','image', 'title', ['author'], 'publishedDate', 'introduction', 'text');
    fetchDataBaseList('PopularCases');
    fetchDataBaseList('AllCases');
    fetchDataBaseList('NewCases');
    getUserRole();
    getGuestList();
  }

  getUserRole() async {
    User firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser.isAnonymous) {
      setState(() {
        currentUserRole = 'Guest';
      });
    } else {
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
    } else {
      print('resultant is null');
    }
  }

  fetchDataBaseList(String folder) async {
    dynamic resultant = await db.getCaseItems(folder);

    if (resultant == null) {
      print('unable to get data');
    } else {
      setState(() {
        switch (folder) {
          case 'PopularCases':
            {
              popularCases = resultant;
            }
            break;

          case 'NewCases':
            {
              newCases = resultant;
            }
            break;
          case 'AllCases':
            {
              allCases = resultant;
            }
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //returns a material design
    return Scaffold(
      //this is the appbar for the home page
      appBar: BaseAppBar(
        title: Text(
          'DIGI-TALT.NO',
          style: TextStyle(color: Colors.white),
        ),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      bottomNavigationBar: BaseBottomAppBar(),

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),

      //here comes the body of the home page
      body: SingleChildScrollView(
          child: Center(
        child: Container(
            width: 800,
            child: Material(
              child: Column(
                children: [
                  ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(
                        lg: 8,
                        xs: 12,
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 320,
                                child: ListView(
                                  children: <Widget>[
                                    //should we add a play and stop button?
                                    BaseCarouselSlider(popularCases)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xs: 12,
                        child: Container(
                          width: 400,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Siste Nytt',
                                    style: TextStyle(
                                      fontSize: 25,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  children: newCases.map((caseObject) {
                                    return Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      //makes the onclick available
                                      return GestureDetector(
                                          onTap: () {
                                            switch (currentUserRole) {
                                              case 'Admin':
                                                {
                                                  if (guestList.contains(
                                                      caseObject['title'])) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    CasePage(
                                                                      image: caseObject[
                                                                          'image'],
                                                                      title: caseObject[
                                                                          'title'],
                                                                      author: caseObject[
                                                                          'author'],
                                                                      publishedDate:
                                                                          caseObject[
                                                                              'publishedDate'],
                                                                      introduction:
                                                                          caseObject[
                                                                              'introduction'],
                                                                      text: caseObject[
                                                                          'text'],
                                                                      lastEdited:
                                                                          caseObject[
                                                                              'lastEdited'],
                                                                    )));
                                                  }
                                                }
                                                break;
                                              case 'User':
                                                {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  CasePage(
                                                                    image: caseObject[
                                                                        'image'],
                                                                    title: caseObject[
                                                                        'title'],
                                                                    author: caseObject[
                                                                        'author'],
                                                                    publishedDate:
                                                                        caseObject[
                                                                            'publishedDate'],
                                                                    introduction:
                                                                        caseObject[
                                                                            'introduction'],
                                                                    text: caseObject[
                                                                        'text'],
                                                                    lastEdited:
                                                                        caseObject[
                                                                            'lastEdited'],
                                                                  )));
                                                }
                                                break;
                                              case 'Guest':
                                                {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfilePage()));
                                                }
                                                break;
                                            }
                                          },
                                          child: Container(
                                              //height: 40,
                                              width: 500,
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade600)),
                                              margin: EdgeInsets.fromLTRB(
                                                  5, 3, 5, 3),
                                              alignment: Alignment.topLeft,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  caseObject['title'],
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.normal),
                                                ),
                                              )));
                                    });
                                  }).toList(),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ResponsiveGridRow(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: allCases.map((caseObject) {
                      return ResponsiveGridCol(
                          lg: 4,
                          md: 6,
                          xs: 12,
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: 250,
                              child: GestureDetector(
                                  onTap: () {
                                    switch (currentUserRole) {
                                      case 'Admin':
                                        {
                                          if (guestList
                                              .contains(caseObject['title'])) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CasePage(
                                                          image: caseObject[
                                                              'image'],
                                                          title: caseObject[
                                                              'title'],
                                                          author: caseObject[
                                                              'author'],
                                                          publishedDate:
                                                              caseObject[
                                                                  'publishedDate'],
                                                          introduction:
                                                              caseObject[
                                                                  'introduction'],
                                                          text: caseObject[
                                                              'text'],
                                                          lastEdited:
                                                              caseObject[
                                                                  'lastEdited'],
                                                        )));
                                          }
                                        }
                                        break;
                                      case 'User':
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CasePage(
                                                        image:
                                                            caseObject['image'],
                                                        title:
                                                            caseObject['title'],
                                                        author: caseObject[
                                                            'author'],
                                                        publishedDate:
                                                            caseObject[
                                                                'publishedDate'],
                                                        introduction:
                                                            caseObject[
                                                                'introduction'],
                                                        text:
                                                            caseObject['text'],
                                                        lastEdited: caseObject[
                                                            'lastEdited'],
                                                      )));
                                        }
                                        break;
                                      case 'Guest':
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage()));
                                        }
                                        break;
                                    }
                                  },
                                  child: BaseCaseBox(
                                      image: caseObject['image'],
                                      title: caseObject['title']))));
                    }).toList(),
                  ),
                ],
              ),
            )),
      )),
    );
  }
}
