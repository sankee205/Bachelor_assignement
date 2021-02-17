import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalt_application/Permanent%20services/caseItem.dart';
import 'package:flutter/material.dart';

import '../casePage.dart';

class BaseCarouselSlider extends StatefulWidget {
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
            child: Container(
              width: 400,
              height: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(caseitem.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    caseitem.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
            ),
          );
        });
      }).toList(),
    );
  }
}
