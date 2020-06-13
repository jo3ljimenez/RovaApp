//import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rova_app/menu_structures/list_product_section.dart';
import 'menu_structures/menu_sales.dart';

void main() => runApp(RovaMain());

class RovaMain extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]); //No permite girar pantalla

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: 
      Colors.transparent, 
      statusBarBrightness: Brightness.light
    )); //Hacer transparente el statusbar

    return MaterialApp(home: HomeMain());
  }
}

class HomeMain extends StatefulWidget {

  @override
  _HomeMain createState() => _HomeMain();
}

class _HomeMain extends State<HomeMain> {
  final MenuSales _menuSales = new MenuSales();
  final MenuTicket _menuTicket = new MenuTicket(); 
  
  GlobalKey _bottomNavigationKey = GlobalKey();
  int pageIndex = 1;

  Widget _selectPage(int index){
    Widget page;
    switch (index) {
      case 0:
        page = _menuTicket;
        break;
      case 1:
        page = _menuSales;
        break;
    }
    return page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        color: Colors.red[700],
        backgroundColor: Colors.white10,
        buttonBackgroundColor: Colors.red[700],
        height: 60,
        animationDuration: Duration(milliseconds: 250),
        animationCurve: Curves.ease,
        key: _bottomNavigationKey,
        items: <Widget> [
          Icon(Icons.receipt, size: 20, color: Colors.white,),
          Icon(Icons.format_list_bulleted, size: 20, color: Colors.white,),
        ],
        onTap: (index){
          setState(() {
            pageIndex = index;
            debugPrint('index: $index');
          });
        },
      ),
      body: _selectPage(pageIndex),
    );
  }
}