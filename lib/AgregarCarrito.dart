import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/Productos.dart';
import 'package:flutter/material.dart';

class AgregarCarrito extends StatefulWidget {
  

  @override
  _AgregarCarritoState createState() => _AgregarCarritoState();
}

class _AgregarCarritoState extends State<AgregarCarrito> {

  
  final referenciaBaseDatos = Firestore.instance;
  final _formulario = GlobalKey<FormState>();
  String nombre;
  double precio;
  
  double contador = 1;

  String _title;

  double _precio;

  String _imagenUrl;

  _saveTodo() {
    final formsState = _formulario.currentState;
    if (!formsState.validate()) return;
    formsState.save();
    print("hola");
    Navigator.of(context).pop(Productos(
        tipo: "n",
        precio: 2.22,
        nombre: "",
        imgUrl: "",
        keyProducto: "",
        cantidad: contador,
        precioDeVenta: 8.5,
        unidad: "",
        peso: 8.5));
  }

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: Text("Agregar Carrito"),
      contentPadding: EdgeInsets.all(20.0),
      content: SingleChildScrollView(
        child: Form(
            key: _formulario,
            child: Flex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  "http://www.golosinaspormayor.com/ventaonline/wp-content/uploads/galletitas-pepitos.jpg",
                  height: 250,
                  width: 250,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.remove),
                      onPressed: () {quitarValor();},
                    ),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: TextEditingController(text: contador.toString()),
                          textAlign: TextAlign.center,
                          onSaved: (val) {
                            setState(() {
                              contador = double.parse(val);
                            });
                          },
                          decoration: InputDecoration(
                              labelText: "Cantidad", alignLabelWithHint: true),
                          validator: (val) =>
                              val == "" ? "ingrese texto" : null,
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        agregarValor();
                      },
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
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

  void agregarValor() {
    setState(() {
      contador = contador + 1;
    });
  }
   void quitarValor() {
    setState(() {
      if(contador>1){
      contador = contador - 1;}
    });
  }
}
