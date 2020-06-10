import 'package:rova_app/objects_structures/product.dart';

class Note{
  final List<NoteDetail> detail;
  final String mesa;
  Note(this.mesa, {this.detail});

  void addProduct(NoteDetail noteDetail){
    detail.add(noteDetail);
  }

  void removeProduct(NoteDetail noteDetail){
    detail.remove(noteDetail);
  }

}

class NoteDetail {
  final Product product;
  final int quality;
  final String note;
  NoteDetail({this.note, this.product, this.quality});
}

