import 'package:flutter/material.dart';
import 'BaseCaseItem.dart';

class BaseCaseBox extends StatefulWidget {
  final CaseItem caseItem;
  const BaseCaseBox(this.caseItem);

  @override
  _BaseCaseBoxState createState() => _BaseCaseBoxState();
}

class _BaseCaseBoxState extends State<BaseCaseBox> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
        footer: Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(0), boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.8),
                blurRadius: 0,
                offset: Offset(0, 3),
                spreadRadius: 5)
          ]),
          //here comes the Text of the CaseBox
          child: ListTile(
            title: Text(
              widget.caseItem.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
            ),
          ),
        ),
        //this is the Image of the CaseBox
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(
                  image: AssetImage(widget.caseItem.image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                    offset: Offset(0, 3),
                    spreadRadius: 5)
              ]),
        ));
  }
}