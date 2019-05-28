import 'package:contabilidad/src/blocs/agregar_producto_bloc.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:contabilidad/src/screens/productos/actualizar_producto.dart';
import 'package:flutter/material.dart';

class CardProducto extends StatelessWidget {
  final Productos modeloP;
  CardProducto({this.modeloP});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getEditProducto(context);
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Image.network(
                    modeloP.imgUrl,
                    filterQuality: FilterQuality.none,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  modeloP.nombre,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          )),
    );
  }

  void getEditProducto(BuildContext context) async {
    Productos prod = await showDialog(
        builder: (_) => ActualizarProductoDialog(modelo: modeloP,), context: context);
    if(prod!=null){
      agregarProductosBloc.actualizaP(prod);
  }}
}
