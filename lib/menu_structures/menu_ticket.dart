
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rova_app/menu_structures/header.dart';
import 'package:rova_app/objects_structures/ticket.dart';

class MenuTicket extends StatefulWidget {
  final Function functionNotificationQuality;

  const MenuTicket({Key key, this.functionNotificationQuality}) : super(key: key); 

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

  void _addProductQuality(int index){
    setState(() {
      _ticket.detail[index].quality += 1 ;
    });
  }
  
  void _removeProductQuality(int index){
    setState(() {
      _ticket.detail[index].quality -= 1 ;
      if (_ticket.detail[index].quality == 0) {
        _ticket.removeProduct(_ticket.detail[index]);
      }
    });
  }

  Widget _circularMenuItemStructure(IconData icon, Color color, Function function){
    return CircularMenuItem(
      icon: icon,
      color: color,
      boxShadow: [ 
        BoxShadow(
          blurRadius: 10,
          offset: Offset(-1, 5),
          spreadRadius: 0.5,
          color: Colors.grey
        )
      ],
      iconColor: Colors.white,
      onTap: (){
        function();
      },
    );
  }

  void _clearProductList(){
    if (_ticket.countDetail() > 0) {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Limpiar comanda.",
        desc: "Se elimarán los productos registrados en la comanda ¿desea continuar?",
        buttons: [
          DialogButton(
            child: Text(
              "No",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          ),
          DialogButton(
            child: Text(
              "Sí",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){
              setState(() {
                _ticket.clearList();
                widget.functionNotificationQuality();
              });
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    var formato  = new NumberFormat("#,##0.00", "es_mx");
    return Theme(
      data: ThemeData(
        primaryColor: Colors.red[700],
        primaryColorDark: Colors.red[700],
        hintColor: Colors.transparent
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            MenuHeader(),
            Container(
              //color: Colors.red[700],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      borderSide: BorderSide(color: Colors.black),
                      ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ), 
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Colors.white24,
                    hintText: 'Cliente',
                  ),
                ),
              ),
            ),
            Expanded(
              child:Card(
                elevation: 5,
                
                child: Stack(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _ticket.lengthList(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 8.0, 
                            horizontal: 5.0
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
                                            Text('${formato.format(_ticket.detail[index].product.price)} ${formato.currencySymbol}'),
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
                                                      _removeProductQuality(index);
                                                      widget.functionNotificationQuality();
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
                                                      _addProductQuality(index);
                                                      widget.functionNotificationQuality();
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Stack(
                                                children: <Widget>[
                                                  Text(
                                                    '${formato.format(sumProduct(index, _ticket.detail[index].quality))} ${formato.currencySymbol}',
                                                    style: TextStyle(
                                                      color: Colors.green[700],
                                                      fontSize: 15
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: CircularMenu(
                        alignment: Alignment.centerRight,
                        animationDuration: Duration(milliseconds: 400),
                        toggleButtonColor: Colors.red[700],
                        toggleButtonIconColor: Colors.white,
                        radius: 90,
                        toggleButtonSize: 30,
                        curve: Curves.easeInOutBack,
                        reverseCurve: Curves.easeInOutBack,
                        toggleButtonBoxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.grey,
                            offset: Offset(-1, 5),
                            spreadRadius: 2
                          )
                        ],
                        items: [
                          _circularMenuItemStructure(Icons.note_add,  Colors.red[700], null),
                          _circularMenuItemStructure(Icons.clear_all,  Colors.red[700], _clearProductList),
                        ]
                      ),
                    ),
                  ],
                ),
              ), 
            ),
          ],
        ),
      ),
    );
  }
}