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

class UpdatePopularLists extends StatefulWidget {
  @override
  _UpdatePopularListsState createState() => _UpdatePopularListsState();
}

class _UpdatePopularListsState extends State<UpdatePopularLists> {
  List<BoardList> _lists = [];
  BoardListObject popularBoardList;
  BoardListObject allBoardList;

  List<BoardListObject> _listData = [];
  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = new BoardViewController();

  final DatabaseService db = DatabaseService();
  List allCases;
  List popularCases;

  @override
  void initState() {
    super.initState();
    fetchDataBaseList('PopularCases');
    fetchDataBaseList('AllCases');
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
          case 'AllCases':
            {
              allCases = resultant;
            }
            break;
        }
      });
    }
  }

  createListData() {
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i]) as BoardList);
    }
  }

  fromMapToBoardList() {
    BoardListObject popBoard = BoardListObject(title: "Populære Saker");
    BoardListObject allBoard = BoardListObject(title: "Alle saker");

    if (popularCases != null && allCases != null) {
      for (int i = 0; i < popularCases.length; i++) {
        var caseObject = popularCases[i];
        popBoard.items.add(BoardItemObject(title: caseObject['title']));
      }
      for (int i = 0; i < allCases.length; i++) {
        var caseObject = allCases[i];
        allBoard.items.add(BoardItemObject(title: caseObject['title']));
      }
      setState(() {
        allBoardList = allBoard;
        popularBoardList = popBoard;
        _listData.add(popularBoardList);
        _listData.add(allBoardList);
      });
    }
  }

  Future<bool> updatePopularCaseList() {
    List<BoardItemObject> theList = _listData[0].items;
    List<String> newPopularCaseList = [];
    for (int i = 0; i < theList.length; i++) {
      BoardItemObject objectITem = theList[i];
      newPopularCaseList.add(objectITem.title);
    }

    return createNewPopularCaseList(newPopularCaseList);
  }

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

    var result = await db.updateFolder('PopularCases', listToFirebase);
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
          'DIGI-TALT.NO',
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
              'Rediger Sakene i Den Populære Listen',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 560,
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
