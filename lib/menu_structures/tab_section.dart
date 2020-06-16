import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rova_app/objects_structures/product.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:rova_app/objects_structures/ticket.dart';
import 'package:rova_app/objects_structures/ticket_detail.dart';

class TabSection extends StatelessWidget {
  final List<Product> listProducts;
  final Function functionNotificationQuality;
  TabSection({Key key, @required this.listProducts, @required this.functionNotificationQuality}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var newMap = groupBy(listProducts, (obj) => (obj as Product).typeProduct);
    return DefaultTabController(
      length: newMap.length, 
      child: Column(
        children: <Widget>[
          TabStructure(mapProducts: newMap),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(), //deshabilita las fisicas del scroll dentro de la tabbarview
                children: [
                  for (var value in newMap.values) 
                    TabViewStructure(
                      functionNotificationQuality: functionNotificationQuality,
                      listProducts: listProducts, 
                      idType: value[0].idTypeProduct,
                    ),   
                ]
              ),
            ),
          ),
        ],
      )
    );
  }
}

class TabStructure extends StatelessWidget {
  final Map mapProducts;
  
  const TabStructure({
    Key key, this.mapProducts
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        isScrollable: true,
        unselectedLabelColor: Colors.red[700],
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.red[700], 
        ),
        tabs: <Widget>[
          for (var key in mapProducts.keys) 
            Tab(
            child: Container(
              constraints: BoxConstraints.expand(width: 120),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                  color: Colors.red[700], 
                  width: 2,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(key),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabViewStructure extends StatelessWidget {
  final List<Product> listProducts;
  final int idType;
  final Function functionNotificationQuality;

  const TabViewStructure({
    Key key, 
    this.listProducts, 
    this.idType, @required this.functionNotificationQuality
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var filterList = listProducts.where((element) => element.idTypeProduct == idType).toList();
    return ListView.builder(
      //itemExtent: 106.0, //demo code
      padding: const EdgeInsets.all(10),
      itemCount: filterList.length,
      itemBuilder: (BuildContext context, int index){
        return Container(
          child: Column(
            children: <Widget>[
              ProductStructure(product:filterList[index], functionNotificationQuality: functionNotificationQuality,),
            ],
          ),
        );
      },
    );
  }

}

class ProductStructure extends StatelessWidget {
  final Product product;
  final Function functionNotificationQuality;
  
  const ProductStructure({
    Key key, 
    this.product, this.functionNotificationQuality
  }) : super(key: key);


  
  @override
  Widget build(BuildContext context) {
    var formato  = new NumberFormat("#,##0.00", "es_mx");
    return Card(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
          child: SizedBox(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.3,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        product.urlImage,
                        fit: BoxFit.fill,
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 2.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${product.name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  //color: Colors.red[900],
                                  fontSize: 20
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 2.0),
                                child: Text(
                                  '${product.description}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54
                                  ),
                                ),
                              ),
                            ], 
                          ),
                        ),
                        Container(
                          height: 30,
                          child:  Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '${formato.format(product.price)} ${formato.currencySymbol}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                FlatButton(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  shape: CircleBorder(),
                                  color: Colors.blue,
                                  onPressed: (){
                                    addToTicket();
                                    functionNotificationQuality();
                                  },
                                ),
                              ],
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ), 
      ),
    );
  }

  void addToTicket(){
    Ticket _ticket = new Ticket();
    TicketDetail detail = new TicketDetail(
      product: this.product,
      quality: 1
     );
    _ticket.addProduct(detail);
    _ticket.countDetail();
  }
}