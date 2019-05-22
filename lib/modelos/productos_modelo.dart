import 'package:cloud_firestore/cloud_firestore.dart';

class Productos {
  String keyProducto;
  String nombre;
  double cantidad;
  double precio;
  double precioDeVenta;
  double peso;
  String imgUrl;
  String tipo;
  String unidad;
  int codBarra;

  Productos(
      {
      this.codBarra,
      this.keyProducto,
      this.nombre,
      this.unidad,
      this.cantidad,
      this.imgUrl,
      this.precioDeVenta,
      this.peso,
      this.precio,
      this.tipo});

  factory Productos.fromSnapshot(DocumentSnapshot snapshot){
    var data=snapshot;
   
  return Productos(
      cantidad: data['cantidad'] ?? 1.1,
      codBarra: data['codBarra']??9,
      imgUrl: data['imgUrl'] ?? '',
      keyProducto: data.documentID??'',
      nombre: data['nombre']??'',
      peso: data['peso']??1.1,
      precio: data['precio']??1.1,
      precioDeVenta: data['precioDeVenta']??1.1,
      tipo: data['tipo']??'',
      unidad: data['unidad']??'');}

}
