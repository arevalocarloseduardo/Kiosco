import 'package:contabilidad/Kiosco.dart';
import 'package:contabilidad/SistemaCrud.dart';
import 'package:contabilidad/SistemaKiosco.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SistemaKiosco _sistema=SistemaKiosco();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _sistema.getWidgetKiosco(),
    );
  }
}