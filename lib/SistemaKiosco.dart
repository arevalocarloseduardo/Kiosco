import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/Carrito.dart';
import 'package:contabilidad/Historial.dart';
import 'package:contabilidad/Kiosco.dart';
import 'package:contabilidad/Productos.dart';
import 'package:flutter/material.dart';

class SistemaKiosco{
  Carrito carrito=new Carrito();
  final referenciaDeProductos = Firestore.instance;
  Historial historial; 
  Kiosco widgetKiosco;

  Carrito getCarrito(){

    return carrito;
  }

  Kiosco getWidgetKiosco(){
    return widgetKiosco;
  }
 

}
