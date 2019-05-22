import 'package:contabilidad/modelos/productos_modelo.dart';
import 'package:flutter/material.dart';

class CardProducto extends StatelessWidget {
  final Productos modeloP;
  CardProducto({this.modeloP});
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Image.network(
                  modeloP.imgUrl,
                  filterQuality: FilterQuality.none,
                  fit: BoxFit.contain,
                ),
              ),
              Text(modeloP.nombre,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
            ],
          ),
        ));
  }
}
