import 'package:contabilidad/modelos/ventas_modelo.dart';
import 'package:flutter/material.dart';

class CardVenta extends StatelessWidget {
  final Venta modelo;
  CardVenta({this.modelo});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.access_time),
                Text(modelo.hora),
              ],
            ),
          ],
        ),
        title: Text("Productos Vendidos"),
        subtitle: Text(modelo.fecha),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.monetization_on,
                  color: Colors.black38,
                ),
                Text("${modelo.totalVendido}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
