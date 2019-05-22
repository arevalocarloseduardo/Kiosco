import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/Carrito.dart';
import 'package:contabilidad/Historial.dart';
import 'package:contabilidad/Kiosco.dart';
import 'package:flutter/material.dart';

class SistemaKiosco {
  final referenciaDeProductos = Firestore.instance;
  Carrito carrito = Carrito();
  Historial historial;
  Kiosco widgetKiosco = Kiosco();
  Carrito getCarrito() {
    return carrito;
  }

  Kiosco getWidgetKiosco() {
    return widgetKiosco;
  }
}
