import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:contabilidad/modelos/productos_modelo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LectorCodigo extends StatefulWidget {
  @override
  _LectorCodigoState createState() => _LectorCodigoState();
}

class _LectorCodigoState extends State<LectorCodigo> 
{
  String codigoDeBarra = "";

  var contador;

  var _formulario;
 @override
  initState() {
    super.initState();
    scan();
  }
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text("Agregar al Carrito",textAlign: TextAlign.center,style: TextStyle(color: Colors.blueAccent),),
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
                  height: 150,
                  width: 150,
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

  _saveTodo() {
    final formsState = _formulario.currentState;
    if (!formsState.validate()) return;
    formsState.save();
    Navigator.of(context).pop(Productos(
        codBarra: 93,
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
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.codigoDeBarra = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.codigoDeBarra = 'No tiene Permisos';
        });
      } else {
        setState(() => this.codigoDeBarra = 'Error desconocido: $e');
      }
    } on FormatException {
      setState(() =>
          this.codigoDeBarra = 'no escaneo nada, posiblemente retrocedio');
    } catch (e) {
      setState(() => this.codigoDeBarra = 'Error desconocido: $e');
    }
  }
}
