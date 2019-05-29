import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/src/modelos/carrito_modelo.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:flutter/material.dart';

class CardCarritoVenta extends StatefulWidget {
  final CarritoModelo modeloP;

  CardCarritoVenta({this.modeloP});

  @override
  _CardCarritoVentaState createState() => _CardCarritoVentaState();
}

class _CardCarritoVentaState extends State<CardCarritoVenta> {
  String _imgP =
      "https://pbs.twimg.com/profile_images/469370081101627392/T9EB8LNZ_400x400.png";
  String _nombreP = "f";
  String _precioP = "12";
  StreamSubscription sub;
  final db = Firestore.instance;
  
  Map data;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    sub = db
        .collection('Productos')
        .document(widget.modeloP.idProducto)
        .snapshots()
        .listen((snap) {
      setState(() {
        data = snap.data;
        _imgP=data['imgUrl'];
        
        _precioP=data['precioDeVenta'].toString();
        
        _nombreP=data['nombre'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (ondi) {},
      child: Card(
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
                    Image.network(
                      _imgP,
                      width: 30,
                      height: 30,
                    )
                  ],
                ),
              ],
            ),
            title: Text(_nombreP),
            subtitle: Row(
              children: <Widget>[
                Icon(
                      Icons.monetization_on,
                      color: Colors.black38,size: 16,
                    ),
                Text(_precioP),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                   
                    Text("${widget.modeloP.cantidad}"),
                  ],
                ),
              ],
            ),
          )),
      key: Key(widget.modeloP.idProducto),
    );
  }
}
