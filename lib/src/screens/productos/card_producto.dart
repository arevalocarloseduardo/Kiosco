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
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Image.network(
                    modeloP.imgUrl,
                    filterQuality: FilterQuality.none,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  modeloP.nombre,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Positioned(
                  bottom: 0.1,
                  right: 0.1,
                  child: Container(color: Colors.black45,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.attach_money,size: 15,color: Colors.white,),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                          '${modeloP.precioDeVenta.toStringAsFixed(2)}',textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void getEditProducto(BuildContext context) async {
    Productos prod = await showDialog(
        builder: (_) => ActualizarProductoDialog(
              modelo: modeloP,
            ),
        context: context);
    if (prod != null) {
      agregarProductosBloc.actualizaP(prod);
    }
  }
}
