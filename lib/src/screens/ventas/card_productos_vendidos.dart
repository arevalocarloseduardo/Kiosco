import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/old/Models/Productos.dart';
import 'package:contabilidad/src/modelos/carrito_modelo.dart';
import 'package:flutter/material.dart';

class CardProductoVendidos extends StatefulWidget {
  final CarritoModelo modeloP;
  CardProductoVendidos({this.modeloP});

  @override
  _CardProductoVendidosState createState() => _CardProductoVendidosState();
}

class _CardProductoVendidosState extends State<CardProductoVendidos> {
final db = Firestore.instance;
String nombreP="f";
String imgP="f";
String precioP="f";
  StreamSubscription sub;

  Map data;
@override
  void initState() {
    super.initState();
    sub = db
        .collection('Productos')
        .document(widget.modeloP.idProducto)
        .snapshots()
        .listen((snap) {
      setState(() {
        data = snap.data;
        imgP=data['imgUrl'];
        
        precioP=data['precioDeVenta'].toString();
        
        nombreP=data['nombre'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Text('$nombreP'),
            Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Image.network(
                    imgP,
                    filterQuality: FilterQuality.none,
                    fit: BoxFit.cover,
                  ),
            ),
            Positioned(
              left: 5,
              right: 5,
              bottom: 5,
              top: 5,
              child: Center(
                child: Text(
                  '${widget.modeloP.cantidad}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70,fontSize: 42),
                ),
              ),
            ),
            Positioned(
              bottom: 0.1,
              right: 0.1,
              child: Container(
                color: Colors.black45,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.attach_money,
                      size: 15,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        precioP,
                        textAlign: TextAlign.end,
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
      ),
    );
  }

}
