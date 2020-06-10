
import 'package:flutter/material.dart';
import 'package:rova_app/objects_structures/product.dart';

class MenuTicket extends StatefulWidget {
  @override
  _MenuTicket createState() => _MenuTicket();
}

class _MenuTicket extends State<MenuTicket> {
  //final Note note = null;
  //NoteDetail noteDetail;

  TextEditingController nameController = TextEditingController();
  final List<String> names = <String>['Aby'];
  

void addItemToList(){
    setState(() {
      names.insert(0, nameController.text);
    });
  }

  void addProductToNote(Product product)
  {
    //noteDetail = new NoteDetail(product: product, quality: 1, note: '');
    //note.addProduct(noteDetail);
  }
  
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.red[700],
        primaryColorDark: Colors.red[700]
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue
                    )
                  ),
                  labelText: 'Comanda'
                ),
              ),
            ),  
            RaisedButton(
              child: Text('Add'),
              onPressed: (){
                setState(() {
                  
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: EdgeInsets.all(8),
                    child: Center(
                      child: Text('',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }
              ) 
            )                     
          ],
        ),
      ),
    );
  }
}