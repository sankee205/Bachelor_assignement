import 'package:flutter/cupertino.dart';

/*
 * This is the case item class. it is suposed to reflect a 
 * newspaper case, including title, image and description
 * 
 * @Sander Keedklang
 */
class CaseItem {
  final String image;
  final String title;
  final List<String> author;
  final String publishedDate;
  final String introduction;
  final List<String> description;

  CaseItem(
      {@required this.image,
      @required this.title,
      @required this.author,
      @required this.publishedDate,
      @required this.introduction,
      @required this.description}) {
    assert(image != null);
    assert(title != null);
    assert(author != null);
    assert(publishedDate != null);
    assert(introduction != null);
    assert(description != null);
  }
}
