import 'package:flutter/cupertino.dart';
import 'dart:convert';

/*
 * This is the case item class. it is suposed to reflect a 
 * newspaper case, including title, image and description
 * 
 * @Sander Keedklang
 */

/**
 * this is the caseItem object class.
 */
class CaseItem {
  final String image;
  final String title;
  final List author;
  final String publishedDate;
  final String introduction;
  final List description;

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'author': jsonEncode(author),
      'publishedDate': publishedDate,
      'introduction': introduction,
      'description': jsonEncode(description),
    };
  }

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
