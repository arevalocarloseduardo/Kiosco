import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/old/Models/Productos.dart';
import 'package:contabilidad/old/Tarjeta.dart';
import 'package:flutter/material.dart';

import 'AgregarProductos.dart';
import 'Crud.dart';

class GenerarCarrito extends StatefulWidget {
  @override
  _GenerarCarritoState createState() => _GenerarCarritoState();
}

class _GenerarCarritoState extends State<GenerarCarrito> {
  //Inicializo el objetoCrud
  Crud crudObj = new Crud();
  final referenciaBaseDatos = Firestore.instance;
  String nombre;

  @override
  Widget build(BuildContext context) {
    //Construyo la app
    return Scaffold(
      appBar: AppBar(
        title: Text('Kiosko'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.shopping_cart),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: referenciaBaseDatos.collection('Productos').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: snapshot.data.documents
                        .map((doc) => Tarjetas().construirProductos(doc,context))
                        .toList());
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  void irAAgregarProducto() async{
    Productos item=await showDialog(context: context,builder: (_)=>AgregarProductos()
    );
    if(item!=null){
      await crudObj.crearProducto(item.toJson()); 
    }
  }
}
