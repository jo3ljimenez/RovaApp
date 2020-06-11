import 'package:flutter/material.dart';
import 'package:rova_app/menu_structures/tab_section.dart';
import 'package:rova_app/objects_structures/product.dart';
import 'header.dart';

class MenuSales extends StatefulWidget {

  @override
  _MenuSalesState createState() => _MenuSalesState();
}

class _MenuSalesState extends State<MenuSales> with AutomaticKeepAliveClientMixin<MenuSales>{
  Future<List<Product>> _loadProducts;

  @override
  void initState(){
    _loadProducts = fetchProduct(); //Solo crea el future una vez
    super.initState();
  }
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); //se usa para mantener activo el mixin
    return FutureBuilder(
      future: _loadProducts,
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
          result = CatalogProducts(products: snapshot.data);
        }
        break;
      case ConnectionState.active: //No hacer nada
    }
    return result;
  }

}

class CatalogProducts extends StatelessWidget {
  final List<Product> products;
  
  const CatalogProducts({
    Key key, 
    this.products
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraint){
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    MenuHeader(),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 600,
                            child: TabSection(listProducts: this.products,),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      );
  }
}