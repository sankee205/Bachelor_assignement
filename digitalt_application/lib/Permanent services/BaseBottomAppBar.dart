import 'package:flutter/material.dart';

class BaseBottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  /// you can add more fields that meet your needs

  const BaseBottomAppBar({Key key, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storage),
          label: 'MyArticles',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      selectedItemColor: Colors.red,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
