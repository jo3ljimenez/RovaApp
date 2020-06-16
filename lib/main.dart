//import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/tabs/gf_tabbar.dart';
import 'package:getflutter/components/tabs/gf_tabbar_view.dart';
import 'package:getflutter/getflutter.dart';
import 'package:rova_app/menu_structures/menu_ticket.dart';
import 'package:rova_app/objects_structures/ticket.dart';
import 'menu_structures/menu_sales.dart';

void main() => runApp(MaterialApp(home: HomeMain()));

class HomeMain extends StatefulWidget {

  @override
  _HomeMain createState() => _HomeMain();
  
}

class _HomeMain extends State<HomeMain> with SingleTickerProviderStateMixin{
  TabController _tabController;
  List<Widget> _pages;
  Ticket _ticket = new Ticket();
  int count = 0;
 
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pages = [
      MenuTicket(functionNotificationQuality: countDetail),
      /* Nota
      Mejorar esta clase, se muetran problemas en el debug console, esta clase esta mal estructurada
      y se manda el metoso countDetail por distintas clases, mejorar diseños en un fututo
      */
      MenuSales(functionNotificationQuality: countDetail), 
      Center(child: Text('Page 3')),
    ];
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }
  
  countDetail(){
    setState(() {
      count = _ticket.countDetail();
    });
  }

  Tab _tabBarStructure(Icon icon, String title, bool notification){
    return Tab(
      icon: Container(
        child: GFIconBadge(
          child: icon, 
          counterChild: notification == false ? null : _ticket.countDetail() == 0 ? null : GFBadge(
            child: Text('$count'),
            color: Colors.blue[600],
            shape:  GFBadgeShape.circle,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 12),
      ),
    );
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
       body: GFTabBarView(
        controller: _tabController,
        children: _pages,
      ),
      bottomNavigationBar: GFTabBar(
        tabBarColor: Colors.red[800],
        //indicatorColor: Colors.blue,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white, 
              width: 4.0
            )
          )
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        tabBarHeight: 60.0,
        initialIndex: 2,
        length: _pages.length,
        controller: _tabController,
        tabs: <Widget>[
          _tabBarStructure(Icon(Icons.receipt, size: 28), 'Comanda', true),
          _tabBarStructure(Icon(Icons.local_dining, size: 28), 'Productos', false),
          _tabBarStructure(Icon(Icons.playlist_add_check, size: 28), 'Pedidos', false),
        ],
      ),
    );
  }
}