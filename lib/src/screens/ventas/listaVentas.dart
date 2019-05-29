import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/src/blocs/list_productos_bloc.dart';
import 'package:contabilidad/src/blocs/verVentasPorId.dart';
import 'package:contabilidad/src/modelos/carrito_modelo.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:contabilidad/src/screens/ventas/card_productos_vendidos.dart';
import 'package:flutter/material.dart';

class ListaVentas extends StatefulWidget {
  final String idCarrito;
  ListaVentas(this.idCarrito);

  @override
  _ListaVentasState createState() => _ListaVentasState();
}

class _ListaVentasState extends State<ListaVentas> {
  
  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text("Productos Vendidos"),
          centerTitle: true,
        ),
        body: listaVentas());
  }
  Widget listaVentas() {
    return Container(
      child: StreamBuilder<List<CarritoModelo>>(
        stream: verVentasPorId.productosList,
        builder: (context, snapshot) {
         
          return !snapshot.hasData
              ? CircularProgressIndicator()
              : GridView.builder(
                  itemCount: (snapshot.data.length),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                          return CardProductoVendidos(
                            modeloP: snapshot.data[index],                                                      
                          );
                  },
                );
        },
      ),
    );
  }
}
