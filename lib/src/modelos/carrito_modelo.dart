import 'package:cloud_firestore/cloud_firestore.dart';

class CarritoModelo {
  String idProducto;
  String idCarrito;
  int cantidad;

  CarritoModelo(
      {this.idProducto, this.cantidad, this.idCarrito});

  factory CarritoModelo.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot;
    return CarritoModelo(
        idCarrito: data['idCarrito'] ?? '',
        cantidad: data['cantidad'] ?? 1.1,        
        idProducto: data['idProducto'] ?? '');
  }
  Map<String, dynamic> toJson() {
    return {      
      'idCarrito': idCarrito,      
      'cantidad': cantidad,
      'idProducto': idProducto,
    };
  }
}
