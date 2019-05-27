import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/old/Historial.dart';
import 'package:contabilidad/old/Kiosco.dart';
import 'package:flutter/material.dart';

import 'Carrito.dart';

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
