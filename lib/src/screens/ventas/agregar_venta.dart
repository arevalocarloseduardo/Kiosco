import 'package:contabilidad/src/blocs/ventas_bloc.dart';
import 'package:contabilidad/src/modelos/carrito_modelo.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:contabilidad/src/blocs/carrito_bloc.dart';
import 'package:contabilidad/src/modelos/ventas_modelo.dart';
import 'package:contabilidad/src/screens/ventas/card_carrito_venta.dart';
import 'package:flutter/material.dart';

import 'LectorCodigo.dart';

class AgregarVenta extends StatefulWidget {
  final String uid;
  AgregarVenta({this.uid});

  @override
  _AgregarVentaState createState() => _AgregarVentaState();
}

class _AgregarVentaState extends State<AgregarVenta> {
  var _totalV=0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Agregar Carrito"),
        actions: <Widget>[
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Text("Finalizar"),
              onTap: () {
                finalizar();
              },
            ),
          ))
        ],
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
        child: StreamBuilder<List<CarritoModelo>>(
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
    CarritoModelo productoCarrito =
        await showDialog(context: context, builder: (_) => LectorCodigo());
    if (productoCarrito != null) {
      print("object");
      await carritoBloc.addCardToList(productoCarrito, widget.uid);
    }
  }

  void finalizar() {
    ventasBloc.agregarVenta(Venta(
        idCarrito: widget.uid,
        totalVendido: _totalV,
        idVenta: "",
        hora: DateTime.now().hour.toString(),
        fecha: DateTime.now().day.toString()));
  }
  
}
