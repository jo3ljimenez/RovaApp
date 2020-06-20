import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rova_app/objects_structures/ticket.dart';

class TextNoteStructure extends StatefulWidget {
  final int indexDetail;

  const TextNoteStructure({Key key, this.indexDetail}) : super(key: key);
  @override

  _TextNoteStructureState createState() => _TextNoteStructureState();
}

class _TextNoteStructureState extends State<TextNoteStructure> {
  Ticket _ticket;
  
  @override
  void initState() {
    super.initState();
    _ticket = Ticket();
  }

  @override
  void dispose() {
    super.dispose();
  }  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _ticket.detail[widget.indexDetail].product.name,
          style: TextStyle(
            color: Colors.black
          )
        ),
        centerTitle: true,
        backgroundColor: Colors.red[200],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.red[100],
      ),
    );
  }
}