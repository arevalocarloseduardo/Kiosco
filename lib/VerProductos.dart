import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/AgregarCarrito.dart';
import 'package:contabilidad/AgregarProductos.dart';
import 'package:contabilidad/Carrito.dart';
import 'package:contabilidad/Crud.dart';
import 'package:contabilidad/Models/Productos.dart';
import 'package:contabilidad/Tarjeta.dart';
import 'package:flutter/material.dart';

class VerProducto extends StatefulWidget {
  VerProducto(Carrito carrito);

  @override
  _VerProductoState createState() => _VerProductoState();
}

class _VerProductoState extends State<VerProducto> {
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
        onPressed: () {irAAgregarProducto();
                  },
                  child: Icon(Icons.add),
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
