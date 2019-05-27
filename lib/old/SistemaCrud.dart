
import 'package:contabilidad/old/Tarjeta.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Crud.dart';

class SistemaCrud extends StatefulWidget {
  @override
  SistemaCrudState createState() {
    return SistemaCrudState();
  }
}

class SistemaCrudState extends State<SistemaCrud> {
  String keyProducto;  
  //Inicializo el objetoCrud
  Crud crudObj = new Crud();
  final referenciaBaseDatos = Firestore.instance;
  final _formulario = GlobalKey<FormState>();
  String nombre;

  void agregarProducto()  {
    if (_formulario.currentState.validate()) {
      _formulario.currentState.save();
      crudObj.crearDatos(nombre);
    }}
 
  TextFormField construirForm() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Escribe un nombre',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'regresa el siguiente texto';
        }
      },
      onSaved: (value) => nombre = value,
    );
  }
  @override
  Widget build(BuildContext context) {
    //Construyo la app
    return Scaffold(
      appBar: AppBar(
        title: Text('Kiosko'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: _formulario,
            child: construirForm(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed:agregarProducto,
                child: Text('crear', style: TextStyle(color: Colors.white)),
                color: Colors.green,
              ),
             
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: referenciaBaseDatos.collection('CRUD').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: snapshot.data.documents
                        .map((doc) => Tarjetas().construirItem(doc))
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
}
