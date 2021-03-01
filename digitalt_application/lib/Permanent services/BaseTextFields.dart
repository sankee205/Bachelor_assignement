import 'package:flutter/material.dart';

class BaseTextFields extends StatefulWidget {
  final int index;
  final int maxlines;
  final String hintText;
  final List<String> list;

  const BaseTextFields(this.list, this.index, this.maxlines, this.hintText);

  @override
  _BaseTextFieldsState createState() => _BaseTextFieldsState();
}

class _BaseTextFieldsState extends State<BaseTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = widget.list[widget.index] ?? '';
    });

    return TextField(
      controller: _nameController,
      onChanged: (v) => widget.list[widget.index] = v,
      decoration: InputDecoration(hintText: widget.hintText),
      maxLines: widget.maxlines,
    );
  }
}
