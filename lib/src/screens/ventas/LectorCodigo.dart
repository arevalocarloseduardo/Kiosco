import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contabilidad/old/VerProductos.dart';
import 'package:contabilidad/src/modelos/carrito_modelo.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LectorCodigo extends StatefulWidget {
  @override
  _LectorCodigoState createState() => _LectorCodigoState();
}

class _LectorCodigoState extends State<LectorCodigo> 
{
  String codigoDeBarra = "";
  final db = Firestore.instance;
String _nombreP="f";
String _imgP="f";
String _precioP="f";
  StreamSubscription _sub;


  Map _data;

  int contador=1;
  final formKey = GlobalKey<FormState>();
  final textCodBarraControl = TextEditingController();
 @override
  initState() {
    super.initState();
    scan();    
    textCodBarraControl.text="1";
  }
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text("Agregar al Carrito",textAlign: TextAlign.center,style: TextStyle(color: Colors.blueAccent),),
      contentPadding: EdgeInsets.all(20.0),
      content: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Flex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(_nombreP,style: TextStyle(color: Colors.blueAccent),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(_imgP,
                    height: 150,
                    width: 150,filterQuality: FilterQuality.none,fit: BoxFit.cover,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.remove),mini: true,
                      onPressed: () {quitarValor();},
                    ),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: textCodBarraControl,
                          textAlign: TextAlign.center,
                          onSaved: (val) {
                            setState(() {
                              contador = int.parse(val);
                            });
                          },
                          
                          
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.add),mini: true,
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
          onPressed: saveTodo,
          textColor: Colors.blue,
          child: Text("Agregar"),
        ),
      ],
    );
}

  void saveTodo() {
    final formsState = formKey.currentState;
    formsState.save();
    Navigator.of(context).pop(CarritoModelo(
      idProducto: codigoDeBarra,
      idCarrito: DateTime.now().toString(),        
        cantidad: contador,));
  }
  
  void agregarValor() {
    setState(() {
      contador++;
      textCodBarraControl.text="$contador";
    });
  }
   void quitarValor() {
    setState(() {
      if(contador>1){
        
      contador--;
      textCodBarraControl.text="$contador";}
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
      
            setState(() {
                this.codigoDeBarra = '5';
                verProducto();
                });
          } catch (e) {
            setState(() => this.codigoDeBarra = 'Error desconocido: $e');
          }
        }
      
         verProducto()async {
          _sub = await db
        .collection('Productos')
        .document(codigoDeBarra)
        .snapshots()
        .listen((_snap) {
      setState(() {
        _data = _snap.data;
        _imgP=_data['imgUrl'];        
        _precioP=_data['precioDeVenta'].toString();        
        _nombreP=_data['nombre'];
      });
    });


        }
}
