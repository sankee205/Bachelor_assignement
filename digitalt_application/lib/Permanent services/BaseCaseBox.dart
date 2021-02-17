import 'package:flutter/material.dart';
import '../casePage.dart';
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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(widget.caseItem.image), fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: Offset(0, 3),
                spreadRadius: 5)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.caseItem.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
