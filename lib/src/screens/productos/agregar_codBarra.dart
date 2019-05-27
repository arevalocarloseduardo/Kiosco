import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:contabilidad/src/modelos/productos_modelo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgregarCodBarra extends StatefulWidget {
  @override
  _AgregarCodBarraState createState() => _AgregarCodBarraState();
}

class _AgregarCodBarraState extends State<AgregarCodBarra> 
{
  String codigoDeBarra = "";
 @override
  initState() {
    super.initState();
    scan();
  }
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text("Agregar codigo de barra",textAlign: TextAlign.center,style: TextStyle(color: Colors.blueAccent),),
      contentPadding: EdgeInsets.all(20.0),
      content: Text(codigoDeBarra),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          textColor: Colors.redAccent,
          child: Text("Cancelar"),
        ),
        FlatButton(
          onPressed: (){Navigator.of(context).pop(codigoDeBarra);},
          textColor: Colors.blue,
          child: Text("Agregar"),
        ),
      ],
    );
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
