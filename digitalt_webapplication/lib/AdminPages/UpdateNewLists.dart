import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';

import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:boardview/boardview.dart';

import 'package:flutter/material.dart';

/*class UpdateNewLists extends StatefulWidget {
  @override
  _UpdateNewListsState createState() => _UpdateNewListsState();
}

class _UpdateNewListsState extends State<UpdateNewLists> {
  List<BoardList> _lists = [];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = new BoardViewController();

  final DatabaseService db = DatabaseService();
  List allCases;
  List newCases;

  @override
  void initState() {
    super.initState();
    fetchDataBaseList('NewCases');
    fetchDataBaseList('AllCases');
  }

  fetchDataBaseList(String folder) async {
    dynamic resultant = await db.getCaseItems(folder);
    if (resultant == null) {
      print('unable to get data');
    } else {
      setState(() {
        switch (folder) {
          case 'newCases':
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

  createListData() {
    _lists.clear();
    if (newCases != null) {
      BoardList newBoards = _createBoardList(newCases, 'Siste Nytt');
      _lists.add(newBoards);
    }
    if (allCases != null) {
      BoardList allBoards = _createBoardList(allCases, 'Alle Artikler');
      _lists.add(allBoards);
    }
  }

  updatePopularCaseList() {
    BoardList boardList;
    _lists.where((element) {
      if (element.title == 'Siste Nytt') {
        boardList = element;
      }
      return true;
    });
    for (int i = 0; i < boardList.items.length; i++) {
      BoardItem bi = boardList.items[i];
      print(bi.title);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  updatePopularCaseList();
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

  Widget _createBoardList(List list, String title) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.length; i++) {
      items.insert(i, buildBoardItem(list[i]) as BoardItem);
    }

    return BoardList(
      title: title,
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
                  title,
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: items,
    );
  }

  Widget buildBoardItem(dynamic itemObject) {
    return BoardItem(
        title: itemObject['title'],
        onStartDragItem:
            (int listIndex, int itemIndex, BoardItemState state) {},
        onDropItem: (int listIndex, int itemIndex, int oldListIndex,
            int oldItemIndex, BoardItemState state) {},
        onTapItem:
            (int listIndex, int itemIndex, BoardItemState state) async {},
        item: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(itemObject['title']),
          ),
        ));
  }
}*/
