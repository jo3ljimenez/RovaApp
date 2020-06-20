import 'package:flutter/material.dart';
import 'package:rova_app/menu_structures/catalog/tab_section.dart';
import 'package:rova_app/objects_structures/product.dart';

class CatalogStructure extends StatefulWidget {
  final Function functionNotificationQuality;

  CatalogStructure({Key key, this.functionNotificationQuality}) : super(key: key);

  @override
  _CatalogStructure createState() => _CatalogStructure();
}

class _CatalogStructure extends State<CatalogStructure>{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProduct(),
      builder: (context, snapshot){
        return _connectionState(snapshot);
      },
    );
  }

  Widget _connectionState(AsyncSnapshot snapshot){
    Widget result;  
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        result = Center(child: Text('Error: ${snapshot.error}'),);
        break;
      case ConnectionState.waiting:
        result = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 20,),
              Text('Cargando...')
            ],
          )
        );
        break;
      case ConnectionState.done:
        if (snapshot.hasData && snapshot.data != null) {
          result = CatalogProducts(products: snapshot.data, functionNotificationQuality: widget.functionNotificationQuality);
        }
        break;
      case ConnectionState.active: //No hacer nada
    }
    return result;
  }

}

class CatalogProducts extends StatelessWidget {
  final List<Product> products;
  final Function functionNotificationQuality;
  
  const CatalogProducts({
    Key key, 
    this.products, 
    this.functionNotificationQuality
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraint){
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Container(
                            height:  MediaQuery.of(context).size.height -118,//Tengo que arreglar esto :V
                            child: TabSection(listProducts: this.products, functionNotificationQuality: functionNotificationQuality,),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          );
        }
      );
  }
}