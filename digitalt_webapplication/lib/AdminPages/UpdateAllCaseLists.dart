import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalt_application/AdminPages/AdminPage.dart';
import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Layouts/BoardItemObject.dart';
import 'package:digitalt_application/Layouts/BoardListObject.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';

import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:boardview/boardview.dart';

import 'package:flutter/material.dart';

class UpdateAllCaseLists extends StatefulWidget {
  @override
  _UpdateAllCaseListsState createState() => _UpdateAllCaseListsState();
}

class _UpdateAllCaseListsState extends State<UpdateAllCaseLists> {
  List<BoardList> _lists = [];
  BoardListObject allBoardList;

  List<BoardListObject> _listData = [];
  BoardViewController boardViewController = new BoardViewController();

  final DatabaseService db = DatabaseService();
  List allCases;

  @override
  void initState() {
    super.initState();
    fetchDataBaseList('AllCases');
  }

  ///this method fetched the allcase list from firebase
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

  ///this method creates a boardlist from the listdata list
  createListData() {
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i]) as BoardList);
    }
  }

  /// this method maps the firebaselist and adds it to the listdata
  fromMapToBoardList() {
    BoardListObject allBoard = BoardListObject(title: "Alle saker");

    if (allCases != null) {
      for (int i = 0; i < allCases.length; i++) {
        var caseObject = allCases[i];
        allBoard.items.add(BoardItemObject(title: caseObject['title']));
      }
      setState(() {
        allBoardList = allBoard;
        _listData.add(allBoardList);
      });
    }
  }

  ///this method will update the firebase popularcases list
  Future<bool> updatePopularCaseList() {
    List<BoardItemObject> theList = _listData[0].items;
    List<String> newPopularCaseList = [];
    for (int i = 0; i < theList.length; i++) {
      BoardItemObject objectITem = theList[i];
      newPopularCaseList.add(objectITem.title);
    }

    return createNewPopularCaseList(newPopularCaseList);
  }

  ///this method creates a new list to update in firebase and update it
  Future<bool> createNewPopularCaseList(List<String> newList) async {
    List<Map<String, dynamic>> listToFirebase = [];
    for (int i = 0; i < newList.length; i++) {
      for (int j = 0; j < allCases.length; j++) {
        QueryDocumentSnapshot object = allCases[j];
        if (newList[i].toString() == object['title']) {
          listToFirebase.add(object.data());
        }
      }
    }

    var result = await db.updateFolder('AllCases', listToFirebase);
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    fromMapToBoardList();
    createListData();
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Rediger rekkefølgen på alle artikler',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 280,
              height: 560,
              color: Colors.lightBlueAccent,
              child: Center(
                child: BoardView(
                  lists: _lists,
                  boardViewController: boardViewController,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: FlatButton(
                onPressed: () {
                  showAlertPublishDialog(context);
                },
                child: Text('Submit'),
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  /// this method creates a boardlist
  Widget _createBoardList(BoardListObject list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items.length; i++) {
      items.insert(i, buildBoardItem(list.items[i]) as BoardItem);
    }

    return BoardList(
      onStartDragList: (int listIndex) {},
      onTapList: (int listIndex) async {},
      onDropList: (int listIndex, int oldListIndex) {},
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  list.title,
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: items,
    );
  }

  /// this method creates a boarditem
  Widget buildBoardItem(BoardItemObject itemObject) {
    return BoardItem(
        onStartDragItem:
            (int listIndex, int itemIndex, BoardItemState state) {},
        onDropItem: (int listIndex, int itemIndex, int oldListIndex,
            int oldItemIndex, BoardItemState state) {
          var item = _listData[oldListIndex].items[oldItemIndex];
          _listData[oldListIndex].items.removeAt(oldItemIndex);
          _listData[listIndex].items.insert(itemIndex, item);
        },
        onTapItem:
            (int listIndex, int itemIndex, BoardItemState state) async {},
        item: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(itemObject.title),
          ),
        ));
  }

  ///this method creates a alert dialog
  Widget showAlertPublishDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Nei"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ja"),
      onPressed: () {
        updatePopularCaseList();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdminPage()));
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Publisering Av Endringer"),
      content: Text("Er du sikker på at du vil publisere disse endringene?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
