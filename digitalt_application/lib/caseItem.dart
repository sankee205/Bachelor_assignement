import 'package:flutter/cupertino.dart';

/**
 * This is the case item class. it is suposed to reflect a 
 * newspaper case, including title, image and description
 * 
 * @Sander Keedklang
 */
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
