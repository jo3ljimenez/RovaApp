
import 'package:rova_app/objects_structures/ticket_detail.dart';

class Ticket{
  List<TicketDetail> detail = new List<TicketDetail>();
  String mesa;
  static final Ticket _ticket = Ticket._internal();
  Ticket._internal();

  factory Ticket(){
    return _ticket;
  }

  void addProduct(TicketDetail noteDetail){
    
    int index = _ticket.detail.indexWhere((element) => element.product.idProduct == noteDetail.product.idProduct);

    if(index >= 0)
    {
      _ticket.detail[index].quality += 1;
    }
    else
    {
      _ticket.detail.add(noteDetail);
    }
    
  }

  void removeProduct(TicketDetail noteDetail){
    _ticket.detail.remove(noteDetail);
  }

  int lengthList(){
    int length = 0;

    //Si la lista no tiene elementos manda erro, es lo mismo que 0
    try {
      length = _ticket.detail.length;
    } catch(e) {
      print(e.toString());
    }  

    return length;
  }

  int countDetail(){
    int totalDetail = 0;

    for (var product in _ticket.detail) {
      totalDetail += product.quality;      
    }

    return totalDetail;
  }

}
