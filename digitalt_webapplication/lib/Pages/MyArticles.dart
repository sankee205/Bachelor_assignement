import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Layouts/BaseCaseBox.dart';
import 'package:digitalt_application/Pages/EditProfilePage.dart';
import 'package:digitalt_application/Pages/SingleCasePage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/Services/firestoreService.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

/// this page will display the user profile
class MyArticles extends StatefulWidget {
  @override
  _MyArticlesState createState() => _MyArticlesState();
}

class _MyArticlesState extends State<MyArticles> {
  final AuthService auth = AuthService();
  final FirestoreService firestoreService = FirestoreService();
  final DatabaseService db = DatabaseService();
  BaseUser currentUser = BaseUser();
  List allCases = [];
  List myCases = [];
  List userMyCases = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataBaseList();
    setBaseUser();
  }

  fetchDataBaseList() async {
    dynamic resultant = await db.getCaseItems('AllCases');
    if (resultant == null) {
      print('unable to get data');
    } else {
      setState(() {
        allCases = resultant;
      });
    }
  }

  createMyCaseList() {
    List newList = [];
    if (userMyCases.isNotEmpty) {
      for (int i = 0; i < allCases.length; i++) {
        for (int j = 0; j < userMyCases.length; j++) {
          var object = allCases[i];
          if (object['title'] == userMyCases[j]) {
            newList.add(allCases[i]);
          }
        }
      }
    }
    setState(() {
      myCases = newList;
    });
  }

  setBaseUser() async {
    String userID = auth.getUser();
    BaseUser user = await firestoreService.getUser(userID);
    if (user != null) {
      setState(() {
        currentUser = user;
        userMyCases = user.myCases;
      });
    } else {
      print('user from authservice is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    createMyCaseList();
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
        child: Container(
          child: Center(
            child: Container(
                width: 800,
                child: Material(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Dine Lagrede Artikler',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ResponsiveGridRow(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: myCases.map((caseObject) {
                          return ResponsiveGridCol(
                              lg: 6,
                              md: 6,
                              xs: 6,
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  height: 250,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CasePage(
                                                      image:
                                                          caseObject['image'],
                                                      title:
                                                          caseObject['title'],
                                                      author:
                                                          caseObject['author'],
                                                      publishedDate: caseObject[
                                                          'publishedDate'],
                                                      introduction: caseObject[
                                                          'introduction'],
                                                      text: caseObject['text'],
                                                      lastEdited: caseObject[
                                                          'lastEdited'],
                                                    )));
                                      },
                                      child: BaseCaseBox(
                                          image: caseObject['image'],
                                          title: caseObject['title']))));
                        }).toList(),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
