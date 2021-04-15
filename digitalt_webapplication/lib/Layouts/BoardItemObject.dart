import 'package:flutter/material.dart';

class BoardItemObject {
  String title;

  BoardItemObject({this.title}) {
    if (this.title == null) {
      this.title = "";
    }
  }
}
