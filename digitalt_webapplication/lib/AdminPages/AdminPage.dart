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

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final editArticle = TextEditingController();
  final DatabaseService db = DatabaseService();
  List allCases = [];
  List<String> allCaseList = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchDataBaseList('AllCases');
  }

  /// fetches the list from firebase
  fetchDataBaseList(String folder) async {
    dynamic resultant = await db.getCaseItems(folder);
    if (resultant == null) {
      print('unable to get data');
    } else {
      setState(() {
        allCases = resultant;
      });
    }
  }

  ///creates a stringlist for the searchfield
  createStringList() {
    allCaseList.clear();
    for (int i = 0; i < allCases.length; i++) {
      var caseObject = allCases[i];
      allCaseList.add(caseObject['title']);
    }
  }

  ///this methods sends you to the updatesinglecase page
  updateSingleCase(String title) {
    var caseToEdit;
    for (int i = 0; i < allCases.length; i++) {
      var caseObject = allCases[i];
      if (caseObject['title'] == title) {
        caseToEdit = caseObject;
      }
    }
    if (caseToEdit != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdateCasePage(
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
    createStringList();
    return Scaffold(
      appBar: BaseAppBar(
        title: Text(
          'DIGI-TALT',
          style: TextStyle(color: Colors.white),
        ),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
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
                                    suggestions: allCaseList,
                                    hint: 'Søk etter saken du vil redigere',
                                    searchStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                    validator: (x) {
                                      if (!allCaseList.contains(x) ||
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
                                        editArticle.text = x;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _formKey.currentState.validate();
                                    if (editArticle.text != null) {
                                      updateSingleCase(editArticle.text);
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
                    ]),
              ]),
            ),
          )),
        ),
      ),
    );
  }
}
