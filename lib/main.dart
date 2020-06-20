import 'package:flutter/material.dart';
import 'package:rova_app/menu_structures/catalog/home_main.dart';
import 'package:rova_app/menu_structures/ticket/menu_ticket.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: RouteGenerator.generateRoute,
  )
);

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final Map<String, dynamic> arguments =  settings.arguments; 
     MaterialPageRoute _materialPageRoute;
      switch (settings.name) {
        case '/':
          _materialPageRoute = MaterialPageRoute(builder: (context) => HomeMain());
          break;
        case '/menuTicket':
          _materialPageRoute = MaterialPageRoute(builder: (context) => MenuTicket(functionNotificationQuality: arguments['function']));
        break;
      }
      return _materialPageRoute;
  }
}