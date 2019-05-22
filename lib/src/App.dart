import 'package:contabilidad/src/blocs/ejemplo_bloc.dart';
import 'package:contabilidad/src/blocs/proveedor_bloc.dart';
import 'package:contabilidad/src/screens/menu_kiosco_screen.dart';
import 'package:contabilidad/src/screens/ventas/ventas_kiosco_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KioscoScreen(),
    );
  }
}
