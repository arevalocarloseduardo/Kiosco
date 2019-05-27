import 'package:contabilidad/src/modelos/ventas_modelo.dart';
import 'package:flutter/material.dart';

class Historial {
  List<Venta> ventas;

  List<Venta> dameTusVentas() {
    return ventas;
  }

  List<Venta> dameTusVentasTalDIa(fechadia) {
    List<Venta> venta;
    for (var item in ventas) {
      if (item.fecha == fechadia) {
        venta.add(item);
      }
    }
    return ventas;
  }
  agregarUnaVenta(venta){
    ventas.add(venta);
  }
}
