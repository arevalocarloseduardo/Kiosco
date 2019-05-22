import 'package:cloud_firestore/cloud_firestore.dart';

class Venta {
  String idVenta;
  String fecha;
  String hora;
  String idCarrito;
  double totalVendido;

  Venta(
      {this.idVenta, this.fecha, this.totalVendido, this.hora, this.idCarrito});

  factory Venta.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot;
    return Venta(
        idCarrito: data['idCarrito'] ?? '',
        totalVendido: data['totalVendido'] ?? 1.1,
        hora: data['hora'] ?? '',
        idVenta: data['idVenta'] ?? '',
        fecha: data['fecha'] ?? '');
  }
}
