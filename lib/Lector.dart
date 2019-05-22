import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String codigoDeBarra = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          body: new Center(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new MaterialButton(
                  onPressed: scan,
                  child: new Text("Scanear"),),
              padding: const EdgeInsets.all(8.0),
            ),
            new Text(codigoDeBarra),
          ],
        ),
      )),
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
