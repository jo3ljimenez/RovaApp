
import 'package:flutter/material.dart';
import 'package:rova_app/menu_structures/header.dart';
import 'package:rova_app/objects_structures/ticket.dart';

class MenuTicket extends StatefulWidget {

  @override
  _MenuTicket createState() => _MenuTicket();
}

class _MenuTicket extends State<MenuTicket> {
  Ticket _ticket = new Ticket();

  void addItemToList(){
    setState(() {
    });
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
            MenuHeader(),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                //controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue
                    )
                  ),
                  labelText: 'Cliente',
                  ),
                textAlign: TextAlign.center,
              ),
            ),  
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _ticket.lengthList(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 16.0, 
                      horizontal: 24.0
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16.0),
                          alignment: FractionalOffset.centerLeft,
                          child: Image.network(
                            _ticket.detail[index].product.urlImage,
                            height: 92.0,
                            width: 92.0,
                          ),
                        ),
                        Container(
                          height: 124.0,
                          margin: EdgeInsets.only(left: 46.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF333366),
                            shape: BoxShape.rectangle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                offset: Offset(0.0, 10.0)
                              )
                            ]
                          ),
                        )
                      ],
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