import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/Models/Productos.dart';
import 'package:flutter/material.dart';

class AgregarProductos extends StatefulWidget {
  @override
  _AgregarProductosState createState() => _AgregarProductosState();
}

class _AgregarProductosState extends State<AgregarProductos> {
  final referenciaBaseDatos = Firestore.instance;
  final _formulario = GlobalKey<FormState>();
  String nombre;
  double precio;
  Productos productoC;

  String _title;

  double _precio;

  String _imagenUrl;

  _saveTodo() {
    final formsState = _formulario.currentState;
    if (!formsState.validate()) return;
    formsState.save();
    Navigator.of(context).pop(Productos(
        tipo: "n",
        precio: _precio,
        nombre: _title,
        imgUrl: _imagenUrl,
        keyProducto: "",
        cantidad: 8.52,
        precioDeVenta: 8.5,
        peso: 8.5));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Agregar nuevo producto"),
      contentPadding: EdgeInsets.all(20.0),
      content: Container(
        child: Form(
            key: _formulario,
            child: Flex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  onSaved: (val) {
                    setState(() {
                      _title = val;
                    });
                  },
                  decoration: InputDecoration(labelText: "nombre"),
                  validator: (val) => val == "" ? "ingrese precio" : null,
                ),
                TextFormField(
                  onSaved: (val) {
                    setState(() {
                      _precio = double.parse(val);
                    });
                  },
                  decoration: InputDecoration(labelText: "precio"),
                  validator: (val) => val == "" ? "imagen" : null,
                ),
                TextFormField(
                  onSaved: (val) {
                    setState(() {
                      _imagenUrl = val;
                    });
                  },
                  decoration: InputDecoration(labelText: "imagen"),
                  validator: (val) => val == "" ? "ingrese texto" : null,
                )
              ],
            )),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          textColor: Colors.redAccent,
          child: Text("Cancelar"),
        ),
        FlatButton(
          onPressed: _saveTodo,
          textColor: Colors.blue,
          child: Text("Agregar"),
        ),
      ],
    );
  }
}
