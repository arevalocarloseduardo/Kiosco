import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:contabilidad/src/blocs/carrito_bloc.dart';
import 'package:contabilidad/src/screens/ventas/card_carrito_venta.dart';
import 'package:flutter/material.dart';

import 'LectorCodigo.dart';

class AgregarVenta extends StatelessWidget {
  var prod = Productos(
      tipo: "klss",
      peso: 5.5,
      codBarra: 1,
      keyProducto: "4",
      nombre: "sds",
      unidad: "sd",
      cantidad: 5.5,
      imgUrl: "KLK",
      precio: 50.5,
      precioDeVenta: 4.55);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Agregar Al Carrito"),
      ),
      body: listaCarrito(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: RotatedBox(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Icon(
                  Icons.view_headline,
                  color: Colors.blueAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Icon(
                  Icons.view_headline,
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
          quarterTurns: 3,
        ),
        onPressed: () {
          agregarCarrito(context);
        },
      ),
    );
  }

  Widget listaCarrito() {
    return Container(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Productos>>(
          stream: carritoBloc.carritoList,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return CardCarritoVenta(modeloP: snapshot.data[index]);
                    },
                    itemCount: (snapshot.data.length),
                  );
          },
        ),
      ),
    );
  }

  void agregarCarrito(context) async {
    Productos productoCarrito =
        await showDialog(context: context, builder: (_) => LectorCodigo());
    if (productoCarrito != null) {
      await carritoBloc.addCardToList(productoCarrito);
    }
  }
}
