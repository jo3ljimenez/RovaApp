
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
    _ticket.detail.add(noteDetail);
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
}
