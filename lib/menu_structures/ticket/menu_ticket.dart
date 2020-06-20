
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rova_app/menu_structures/ticket/text_note_structure.dart';
import 'package:rova_app/objects_structures/ticket.dart';

class MenuTicket extends StatefulWidget {
  final Function functionNotificationQuality;
  const MenuTicket({Key key, this.functionNotificationQuality}) : super(key: key);
  
  @override
  _MenuTicket createState() => _MenuTicket();
}

class _MenuTicket extends State<MenuTicket> {
  Ticket _ticket;
  TextEditingController _textController;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textController = TextEditingController();
    _ticket = Ticket();
    loadClient();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _textController.dispose();
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
                _textController.clear();
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
  
  void loadClient(){
    if(_ticket.client != null && _ticket.detail.isNotEmpty){
      _textController.text = _ticket.client;
    }
  }

  @override
  Widget build(BuildContext context) {
    var moneyFormat  = new NumberFormat("#,##0.00", "es_mx");
    return Scaffold(
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.red[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(280,25)
          )
        ),
        elevation: 10,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
              child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  cursorColor: Colors.blue[700],
                  focusNode: _focusNode,
                  controller: _textController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear), 
                      onPressed: (){
                        _textController.clear();
                      }
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    border: OutlineInputBorder(
                      gapPadding: 5,
                      borderSide: BorderSide(
                        color: Colors.blue
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    ),
                    labelText: 'Cliente',
                    hintMaxLines: 1,
                  ),
                  onEditingComplete: (){
                    _ticket.addClient(_textController.text);
                    _focusNode.unfocus();
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${moneyFormat.format(_ticket.getTotalPrice())} ${moneyFormat.currencySymbol}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                      fontSize: 30
                    ),                
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                        offset: Offset(0, 2),
                        spreadRadius: 2
                      )
                    ]
                  ),
                  child: Divider(
                    color: Colors.grey[400],
                    height: 1,
                    thickness: 2,
                  ),
                ),
                height: 1,
              ),
              Expanded(
                child:Stack(
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
                                margin: EdgeInsets.fromLTRB(46, 0, 10, 0),
                                child: Container(
                                  height: 124.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(50, 0, 10, 0),
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
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    Text(
                                                      '${moneyFormat.format(_ticket.detail[index].product.price)} ${moneyFormat.currencySymbol}',
                                                      style: TextStyle(
                                                        color: Colors.green[700],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  icon: Image.asset('assets/images/note.png'), 
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TextNoteStructure(indexDetail: index)));
                                                  }
                                                ) 
                                              ],
                                            ),
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
                                                  ClipOval(
                                                    child: Material(
                                                      color: Colors.blue, // button color
                                                      child: InkWell(
                                                        splashColor: Colors.white10, // inkwell color
                                                        child: SizedBox(
                                                          width: 40, 
                                                          height: 40, 
                                                          child: Icon(Icons.remove, color: Colors.white)
                                                        ),
                                                        onTap: () {
                                                          _removeProductQuality(index);
                                                          widget.functionNotificationQuality();
                                                        },
                                                      ),
                                                    ),
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
                                                  ClipOval(
                                                    child: Material(
                                                      color: Colors.blue, // button color
                                                      child: InkWell(
                                                        splashColor: Colors.white10, // inkwell color
                                                        child: SizedBox(
                                                          width: 40, 
                                                          height: 40, 
                                                          child: Icon(Icons.add, color: Colors.white)
                                                        ),
                                                        onTap: () {
                                                          _addProductQuality(index);
                                                          widget.functionNotificationQuality();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Stack(
                                                children: <Widget>[
                                                  Text(
                                                    '${moneyFormat.format(sumProduct(index, _ticket.detail[index].quality))} ${moneyFormat.currencySymbol}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.green[700],
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
                      padding: EdgeInsets.only(bottom: 60),
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
                            color: Colors.transparent,
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
            ],
          ),
        ),
      ),
    );
  }
}