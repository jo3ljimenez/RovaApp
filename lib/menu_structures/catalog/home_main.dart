import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/getflutter.dart';
import 'package:rova_app/menu_structures/catalog/catalog_structure.dart';
import 'package:rova_app/objects_structures/ticket.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMain createState() => _HomeMain();
  
}

class _HomeMain extends State<HomeMain> with SingleTickerProviderStateMixin{
  Ticket _ticket = new Ticket();
  int countProductsTicket = 0;
  CatalogStructure _menuSales;
 
  @override
  void initState(){
    super.initState();
    _menuSales = new CatalogStructure(functionNotificationQuality: countDetail);
  }

  @override
  void dispose(){
    super.dispose();
  }
  
  countDetail(){
    setState(() {
      countProductsTicket = _ticket.countDetail();
    });
  }

  @override
  Widget build(BuildContext   context) {
      
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]); //No permite girar pantalla

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: 
      Colors.transparent, 
      statusBarBrightness: Brightness.light
    )); //Hacer transparente el statusbar

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
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 30, 5) ,
            child: Row(
              children: <Widget>[
                GFIconBadge(
                  child: GFIconButton(
                    tooltip: 'Comandas',
                    shape: GFIconButtonShape.circle,
                    size: 40,
                    alignment: Alignment.center,
                    color: Colors.red[800],
                    icon: Icon(
                      Icons.receipt,
                      size: 25,
                    ), 
                    onPressed: (){
                      Navigator.pushNamed(context, '/menuTicket', arguments: {"function" : countDetail});
                    },
                  ), 
                  counterChild:  _ticket.countDetail() == 0 ? null : GFBadge(
                    size: 35,
                    color: Colors.blue[600],
                    shape: GFBadgeShape.circle,
                    child: Text('$countProductsTicket'),
                  )
                ),                
              ],
            ),
          ),
        ],
      ),
      body: _menuSales
    );
  }
}