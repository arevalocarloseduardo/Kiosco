import 'package:cloud_firestore/cloud_firestore.dart';

class Productos{
  String keyProducto;
  String nombre ='';
  double cantidad = 0.0;
  double precio = 0.0;
  double precioDeVenta = 0.0;
  double peso = 0.0;
  String imgUrl = '';
  String tipo = '';
  String unidad="";

  Productos({this.keyProducto,this.nombre,this.unidad,this.cantidad,this.imgUrl,this.precioDeVenta,this.peso,this.precio,this.tipo});

  Productos.from(DocumentSnapshot snapshot):
  keyProducto = snapshot.documentID,
  nombre = snapshot['nombre'],
  cantidad = snapshot['cantidad'],
  precio = snapshot['precio'],
  peso = snapshot['peso'],
  precioDeVenta = snapshot['precioDeVenta'],
  imgUrl = snapshot['imgUrl'],
  tipo = snapshot['tipo'],
  unidad = snapshot['unidad'];

  Map<String,dynamic>toJson(){
    return{
      'nombre':nombre,
      'cantidad':cantidad,
      'precio':precio,
      'peso':peso,
      'precioDeVenta':precioDeVenta,
      'imgUrl':imgUrl,
      'tipo':tipo,
      'unidad':unidad,
    };

  }

}