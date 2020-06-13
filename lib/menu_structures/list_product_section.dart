
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  double sumProduct(int index, int qualty){
    double total = 0;
    try {
      total = _ticket.detail[index].product.price * _ticket.detail[index].quality;
    } catch (e) {
    }
    return total;
  }

  void addProductQuality(int index){
    setState(() {
      _ticket.detail[index].quality += 1 ;
    });
  }
  
  void removeProductQuality(int index){
    setState(() {
      _ticket.detail[index].quality -= 1 ;
      if (_ticket.detail[index].quality == 0) {
        _ticket.detail.removeAt(index);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var formato  = new NumberFormat("#,##0.00", "es_mx");
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
              padding: EdgeInsets.all(10),
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
                      vertical: 10.0, 
                      horizontal: 24.0
                    ),
                    child: Stack(
                      children: <Widget>[
                        Card(
                          elevation: 15.0,
                          margin: EdgeInsets.only(left: 46.0),
                          child: Container(
                            height: 124.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(50, 10, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            _ticket.detail[index].product.name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              //color: Colors.red[700],
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w800
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text('${formato.format(_ticket.detail[index].product.price)}${formato.currencySymbol}'),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            FloatingActionButton(
                                              mini: true,
                                              elevation: 3.0,
                                              child: Icon(Icons.arrow_drop_down),
                                              onPressed: (){
                                                removeProductQuality(index);
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Text(
                                                '${_ticket.detail[index].quality}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                            FloatingActionButton(
                                              mini: true,
                                              elevation: 3.0,
                                              child: Icon(Icons.arrow_drop_up),
                                              onPressed: (){
                                                addProductQuality(index);
                                              },
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: <Widget>[
                                            Text(
                                              '${formato.format(sumProduct(index, _ticket.detail[index].quality))} ${formato.currencySymbol}',
                                              style: TextStyle(
                                                color: Colors.green[600]
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     FlatButton(
                                  //       child: Icon(
                                  //         Icons.arrow_drop_down,
                                  //         color: Colors.white,
                                  //       ),
                                  //       shape: CircleBorder(),
                                  //       color: Colors.blue,
                                  //       onPressed: (){
                                  //       },
                                  //     ),
                                  //     Text('${_ticket.detail[index].quality}'),
                                  //   ],
                                  // ),
                                  // Expanded(child: Text('${formato.format(sumProduct(index, _ticket.detail[index].quality))}${formato.currencySymbol}'))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          alignment: FractionalOffset.centerLeft,
                          child: Container(
                            height: 82.0,
                            width: 92.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8.0,
                                  offset: Offset(-10, 10.0),
                                  spreadRadius: 1.0,
                                  color: Colors.grey
                                )
                              ],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  _ticket.detail[index].product.urlImage,
                                ),
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ), 
            ),
          ],
        ),
      ),
    );
  }
}