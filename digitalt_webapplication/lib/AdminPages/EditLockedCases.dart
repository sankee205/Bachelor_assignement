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

///
///this class edits what articles that are available to the guests
class EditLockedCases extends StatefulWidget {
  @override
  _EditLockedCasesState createState() => _EditLockedCasesState();
}

class _EditLockedCasesState extends State<EditLockedCases> {
  List<BoardList> _lists = [];
  BoardListObject _allBoardList;
  BoardListObject _guestBoardList;

  List<BoardListObject> _listData = [];
  BoardViewController _boardViewController = new BoardViewController();

  final DatabaseService _db = DatabaseService();
  List _allCases;
  List<String> _guestList = [];

  @override
  void initState() {
    super.initState();
    _fetchDataBaseList('AllCases');
    _getGuestList();
  }

  ///fetches the lists from firebase
  _fetchDataBaseList(String folder) async {
    dynamic resultant = await _db.getCaseItems(folder);
    if (resultant == null) {
      print('unable to get data');
    } else {
      setState(() {
        _allCases = resultant;
      });
    }
  }

  /// fetches the guestlist from firebase
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
      print(_guestList);
    } else {
      print('resultant is null');
    }
  }

  ///this method creates a boardlist from the listdata list
  _createListData() {
    for (int i = 0; i < _listData.length; i++) {
      _lists.add(_createBoardList(_listData[i]) as BoardList);
    }
  }

  /// this method maps the firebaselist and adds it to the listdata
  _fromMapToBoardList() {
    BoardListObject allBoard = BoardListObject(title: "Alle saker");
    BoardListObject guestBoard = BoardListObject(title: "Gjeste saker");

    if (_guestList.isNotEmpty) {
      for (int i = 0; i < _guestList.length; i++) {
        String title = _guestList[i];
        guestBoard.items.add(BoardItemObject(title: title));
      }
      setState(() {
        _guestBoardList = guestBoard;
        _listData.add(_guestBoardList);
      });
    }
    if (_allCases != null) {
      for (int i = 0; i < _allCases.length; i++) {
        var caseObject = _allCases[i];
        allBoard.items.add(BoardItemObject(title: caseObject['title']));
      }
      setState(() {
        _allBoardList = allBoard;
        _listData.add(_allBoardList);
      });
    }
  }

  ///updates the guestlist
  Future<bool> _updateGuestList() {
    List<BoardItemObject> theList = _listData[0].items;
    List<String> newPopularCaseList = [];
    for (int i = 0; i < theList.length; i++) {
      BoardItemObject objectITem = theList[i];
      newPopularCaseList.add(objectITem.title);
    }
    print(newPopularCaseList);
    return _createNewGuestList(newPopularCaseList);
  }

  /// creates new guestlist from edit stringlist by the admin user
  Future<bool> _createNewGuestList(List<String> newList) async {
    List<Map<String, dynamic>> listToFirebase = [];
    for (int i = 0; i < newList.length; i++) {
      listToFirebase.add({'Title': newList[i]});
    }

    var result = await _db.updateGuestList(listToFirebase);
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _fromMapToBoardList();
    _createListData();
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
              'Rediger hvilke saker som skal være tilgjengelig for gjestebrukere',
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
                  boardViewController: _boardViewController,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: FlatButton(
                onPressed: () {
                  _showAlertPublishDialog(context);
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
      items.insert(i, _buildBoardItem(list.items[i]) as BoardItem);
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

  Widget _buildBoardItem(BoardItemObject itemObject) {
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

  /// alerts the admin user before ushing changes to firebase
  Widget _showAlertPublishDialog(BuildContext context) {
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
        _updateGuestList();
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
