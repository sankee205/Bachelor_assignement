import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalt_application/Layouts/BaseCaseItem.dart';

import 'package:flutter/material.dart';

import '../Pages/SingleCasePage.dart';
import 'BaseCaseBox.dart';

/**
 * this is the carouselslider. is will show the top X cases in the home page
 */
class BaseCarouselSlider extends StatefulWidget {
  //list of cass it gets from the database
  final List<CaseItem> caseList;

  const BaseCarouselSlider(this.caseList);

  @override
  _BaseCarouselSliderState createState() => _BaseCarouselSliderState();
}

class _BaseCarouselSliderState extends State<BaseCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 300,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          aspectRatio: 0.25,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayInterval: Duration(seconds: 10),
          viewportFraction: 0.8,
          initialPage: 0),
      items: widget.caseList.map((caseitem) {
        return Builder(builder: (
          BuildContext context,
        ) {
          //makes the onclick available
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CasePage(
                              caseItem: caseitem,
                            )));
              },
              child: BaseCaseBox(caseitem));
        });
      }).toList(),
    );
  }
}
