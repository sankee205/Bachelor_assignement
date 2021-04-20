import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Layouts/BaseCarouselSlider.dart';
import 'package:digitalt_application/Layouts/BaseCaseBox.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Pages/SingleCasePage.dart';
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

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

// this class represents a home page with a grid layout
class HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  List _newCases = [];
  List _allCases = [];
  List _popularCases = [];

  String _currentUserRole;
  List<String> _guestList = [];

  @override
  void initState() {
    super.initState();
    _fetchDataBaseList('PopularCases');
    _fetchDataBaseList('AllCases');
    _fetchDataBaseList('NewCases');
    _getUserRole();
    _getGuestList();
  }

  _getUserRole() async {
    setState(() {
      _currentUserRole = _auth.getUserRole();
    });
  }

  _getGuestList() async {
    List<String> firebaseList = [];
    List resultant = await _db.getGuestListContent();
    if (resultant != null) {
      for (int i = 0; i < resultant.length; i++) {
        var object = resultant[i];
        firebaseList.add(object['Title'].toString());
      }
      setState(() {
        _guestList = firebaseList;
      });
    } else {
      print('resultant is null');
    }
  }

  _fetchDataBaseList(String folder) async {
    dynamic resultant = await _db.getCaseItems(folder);

    if (resultant == null) {
      print('unable to get data');
    } else {
      setState(() {
        switch (folder) {
          case 'PopularCases':
            {
              _popularCases = resultant;
            }
            break;

          case 'NewCases':
            {
              _newCases = resultant;
            }
            break;
          case 'AllCases':
            {
              _allCases = resultant;
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
                                    BaseCarouselSlider(_popularCases)
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
                                  children: _newCases.map((caseObject) {
                                    return Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      //makes the onclick available
                                      return GestureDetector(
                                          onTap: () {
                                            switch (_currentUserRole) {
                                              case 'Admin':
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
                                              case 'Subscriber':
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
                                              case 'User':
                                                {
                                                  if (_guestList.contains(
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
                                              case 'Guest':
                                                {
                                                  if (_guestList.contains(
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
                    children: _allCases.map((caseObject) {
                      return ResponsiveGridCol(
                          lg: 4,
                          md: 6,
                          xs: 12,
                          child: Container(
                              margin: EdgeInsets.all(5),
                              height: 250,
                              child: GestureDetector(
                                  onTap: () {
                                    switch (_currentUserRole) {
                                      case 'Admin':
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
                                      case 'Subscriber':
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
                                      case 'User':
                                        {
                                          if (_guestList
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
                                      case 'Guest':
                                        {
                                          if (_guestList
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
