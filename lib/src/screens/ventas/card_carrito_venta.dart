import 'package:contabilidad/modelos/productos_modelo.dart';
import 'package:flutter/material.dart';

class CardCarritoVenta extends StatelessWidget {

  final Productos modeloP;
  CardCarritoVenta({this.modeloP});
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child:ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.access_time),
                Text(modeloP.imgUrl),
              ],
            ),
          ],
        ),
        title: Text("Productos Vendidos"),
        subtitle: Text(modeloP.nombre),
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
                Text("${modeloP.cantidad}"),
              ],
            ),
          ],
        ),
      ));
  }
}
