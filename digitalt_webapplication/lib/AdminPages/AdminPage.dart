import 'package:digitalt_application/AdminPages/EditLockedCases.dart';
import 'package:digitalt_application/AdminPages/EditPrivacyPolicy.dart';
import 'package:digitalt_application/AdminPages/EditUserTerms.dart';
import 'package:digitalt_application/AdminPages/UpdateNewLists.dart';
import 'package:digitalt_application/AdminPages/UpdateCasePage.dart';
import 'package:digitalt_application/AdminPages/UpdateInfoPage.dart';
import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:digitalt_application/AdminPages/AddCasePage.dart';
import 'package:searchfield/searchfield.dart';

import 'UpdateAllCaseLists.dart';
import 'UpdatePopularLists.dart';

///
///this is the admin console page. this page will link to the different activities
///one is able to do as an admin user.
class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //gets the database service for activities with the database
  final DatabaseService _db = DatabaseService();

  ///creates a ext editing controller for the search bar
  ///where one can search for articles in the database to edit
  final _editArticle = TextEditingController();

  //lists from firebase with all articles
  List _allCases = [];
  List _popularList = [];
  List _newList = [];
  List<String> _guestList = [];

  //a list with only string objects for the search bar
  List<String> _allCaseList = [];

  //form key to evaluate the search bar input
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchDataBaseList('PopularCases');
    _fetchDataBaseList('AllCases');
    _fetchDataBaseList('NewCases');
    _getGuestList();
  }

  /// fetches the list from firebase
  _fetchDataBaseList(String folder) async {
    dynamic resultant = await _db.getCaseItems(folder);

    if (resultant == null) {
      print('unable to get data');
    } else {
      setState(() {
        switch (folder) {
          case 'PopularCases':
            {
              _popularList = resultant;
            }
            break;

          case 'NewCases':
            {
              _newList = resultant;
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

  ///creates a stringlist for the searchfield
  _createStringList() {
    _allCaseList.clear();
    for (int i = 0; i < _allCases.length; i++) {
      var caseObject = _allCases[i];
      _allCaseList.add(caseObject['title']);
    }
  }

  ///this methods sends you to the updatesinglecase page
  _updateSingleCase(String title) {
    var caseToEdit;
    for (int i = 0; i < _allCases.length; i++) {
      var caseObject = _allCases[i];
      if (caseObject['title'] == title) {
        caseToEdit = caseObject;
      }
    }
    if (caseToEdit != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdateCasePage(
                  popularList: _popularList,
                  newList: _newList,
                  guestList: _guestList,
                  caseTitle: caseToEdit['title'],
                  caseIntroduction: caseToEdit['introduction'],
                  caseText: caseToEdit['text'],
                  caseDate: caseToEdit['publishedDate'],
                  caseAuthorList: caseToEdit['author'],
                  caseImageUrl: caseToEdit['image'],
                  caseId: caseToEdit['id'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    _createStringList();
    return Scaffold(
      appBar: BaseAppBar(
        title: Text(
          'DIGI-TALT.NO',
          style: TextStyle(color: Colors.white),
        ),
        appBar: AppBar(),
        widgets: <Widget>[
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular((20))),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BaseBottomAppBar(),

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),

      body: SingleChildScrollView(
        child: Container(
          child: Center(
              child: Material(
            child: Container(
              width: 600,
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Admin Console',
                  style: TextStyle(fontSize: 20),
                ),
                ResponsiveGridRow(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        xs: 12,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyForm()));
                          },
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.all(5),
                            height: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.article,
                                  size: 50,
                                ),
                                Text('Legg til ny artikkel')
                              ],
                            ),
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        xs: 12,
                        child: Container(
                          color: Colors.grey,
                          margin: EdgeInsets.all(5),
                          height: 200,
                          child: Column(
                            children: [
                              Icon(
                                Icons.article,
                                size: 50,
                              ),
                              Text('Rediger artikkel'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: _formKey,
                                  child: SearchField(
                                    suggestions: _allCaseList,
                                    hint: 'Søk etter saken du vil redigere',
                                    searchStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                    validator: (x) {
                                      if (!_allCaseList.contains(x) ||
                                          x.isEmpty) {
                                        return 'Please Enter a valid State';
                                      }
                                      return null;
                                    },
                                    searchInputDecoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    maxSuggestionsInViewPort: 6,
                                    itemHeight: 50,
                                    onTap: (x) {
                                      setState(() {
                                        _editArticle.text = x;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _formKey.currentState.validate();
                                    if (_editArticle.text != null) {
                                      _updateSingleCase(_editArticle.text);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Rediger'),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        xs: 12,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateInfoPage()));
                          },
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.all(5),
                            height: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.contact_phone_sharp,
                                  size: 50,
                                ),
                                Text('Rediger Informasjon Side')
                              ],
                            ),
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        xs: 12,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateNewLists()));
                          },
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.all(5),
                            height: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.article,
                                  size: 50,
                                ),
                                Text('Rediger artikler i Siste Nytt')
                              ],
                            ),
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        xs: 12,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdatePopularLists()));
                          },
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.all(5),
                            height: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.article,
                                  size: 50,
                                ),
                                Text('Rediger artikler i Populære Saker')
                              ],
                            ),
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        xs: 12,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateAllCaseLists()));
                          },
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.all(5),
                            height: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.article,
                                  size: 50,
                                ),
                                Text('Rediger rekkefølge på alle artikler')
                              ],
                            ),
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        xs: 12,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditLockedCases()));
                          },
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.all(5),
                            height: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.lock,
                                  size: 50,
                                ),
                                Text('Rediger Låste Saker')
                              ],
                            ),
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        xs: 12,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPrivacyPolicy()));
                          },
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.all(5),
                            height: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.security,
                                  size: 50,
                                ),
                                Text('Rediger Bruksvilkår')
                              ],
                            ),
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 12,
                        md: 12,
                        xs: 12,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUserTerms()));
                          },
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.all(5),
                            height: 120,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.privacy_tip,
                                  size: 50,
                                ),
                                Text('Rediger Personvernerklæring')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          )),
        ),
      ),
    );
  }
}
