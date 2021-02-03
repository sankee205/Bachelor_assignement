import 'package:flutter/cupertino.dart';

class CaseItem {
  final String image;
  final String title;
  final String description;

  CaseItem(
      {@required this.image,
      @required this.title,
      @required this.description}) {
    assert(image != null);
    assert(title != null);
    assert(description != null);
  }
}
