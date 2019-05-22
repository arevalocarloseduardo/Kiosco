import 'package:cloud_firestore/cloud_firestore.dart';

class EjemploModelo {
  List<ContenidoModelo> resultados;
  EjemploModelo({this.resultados});
  
  EjemploModelo.fromJson(Map<String, dynamic> json) {
    if (json['productosResultados'] != null) {
      resultados = List<ContenidoModelo>();
      json['productosResultados'].forEach((v) {
        resultados.add(ContenidoModelo.from(v));
      });
    }
  }
  
}

class ContenidoModelo {
  String keyProducto;
  String nombre = '';
  double cantidad = 0.0;
  double precio = 0.0;
  double precioDeVenta = 0.0;
  double peso = 0.0;
  String imgUrl = '';
  String tipo = '';
  String unidad = "";
  int codBarra = 0;

  ContenidoModelo(
      {this.codBarra,
      this.keyProducto,
      this.nombre,
      this.unidad,
      this.cantidad,
      this.imgUrl,
      this.precioDeVenta,
      this.peso,
      this.precio,
      this.tipo});

  ContenidoModelo.from(DocumentSnapshot snapshot)
      : keyProducto = snapshot.documentID,
        nombre = snapshot['nombre'],
        cantidad = snapshot['cantidad'],
        precio = snapshot['precio'],
        peso = snapshot['peso'],
        precioDeVenta = snapshot['precioDeVenta'],
        imgUrl = snapshot['imgUrl'],
        tipo = snapshot['tipo'],
        unidad = snapshot['unidad'],
        codBarra = snapshot['codBarra'];

  ContenidoModelo.fromJson(Map<String, dynamic> json) {
    keyProducto = json['documentID'];
    nombre = json['nombre'];
    cantidad = json['cantidad'];
    precio = json['precio'];
    peso = json['peso'];
    precioDeVenta = json['precioDeVenta'];
    imgUrl = json['imgUrl'];
    tipo = json['tipo'];
    unidad = json['unidad'];
    codBarra = json['codBarra'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'cantidad': cantidad,
      'precio': precio,
      'peso': peso,
      'precioDeVenta': precioDeVenta,
      'imgUrl': imgUrl,
      'tipo': tipo,
      'unidad': unidad,
      'codBarra': codBarra,
    };
  }
}
