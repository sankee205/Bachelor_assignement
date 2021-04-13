import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
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
  List _listData = [];
  List<BoardList> _lists = [];

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
    if (popularCases != null) {
      BoardList newBoards = _createBoardList(popularCases, 'Populære saker');
      _lists.add(newBoards);
    }
    if (allCases != null) {
      BoardList allBoards = _createBoardList(allCases, 'Alle artikler');
      _lists.add(allBoards);
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
      body: Center(
        child: Container(
            width: 560,
            color: Colors.lightBlueAccent,
            child: Center(
              child: BoardView(
                lists: _lists,
                boardViewController: boardViewController,
              ),
            )),
      ),
    );
  }

  Widget _createBoardList(List list, String title) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.length; i++) {
      items.insert(i, buildBoardItem(list[i]) as BoardItem);
    }

    return BoardList(
      onStartDragList: (int listIndex) {},
      onTapList: (int listIndex) async {},
      onDropList: (int listIndex, int oldListIndex) {
        //Update our local list data
        var list = _listData[oldListIndex];
        _listData.removeAt(oldListIndex);
        _listData.insert(listIndex, list);
      },
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
        onStartDragItem:
            (int listIndex, int itemIndex, BoardItemState state) {},
        onDropItem: (int listIndex, int itemIndex, int oldListIndex,
            int oldItemIndex, BoardItemState state) {
          //Used to update our local item data
          var item = _listData[oldListIndex].items[oldItemIndex];
          _listData[oldListIndex].items.removeAt(oldItemIndex);
          _listData[listIndex].items.insert(itemIndex, item);
        },
        onTapItem:
            (int listIndex, int itemIndex, BoardItemState state) async {},
        item: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(itemObject['title']),
          ),
        ));
  }
}
